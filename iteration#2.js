const Koa = require('koa');
const Router = require('@koa/router');
const cors = require('@koa/cors');
const util = require('util');
const app = new Koa();
const router = new Router();

const mysql = require('mysql');
const poolConfig = {
    connectionLimit : 10,
    socketPath: '/var/run/mysqld/mysqld.sock',
    user: 'admin',
    password: 'icaneatglass',
    database: 'Iteration2'
}
const pool  = mysql.createPool(poolConfig)
const query = util.promisify(pool.query).bind(pool);

router
.get('/recipes', async (ctx, next) => {
    try {
        const offset = ctx.request.query.offset || 0
        const count = ctx.request.query.count || 10
        const rtn = await query(`SELECT * from RECIPE limit ${offset}, ${count};`)
        ctx.body = rtn
    } catch (e) {
        ctx.status = 400;
        console.log(e)
        ctx.body = {
            error: e.toString()
        };
    }
})
.get('/recipes/count', async (ctx, next) => {
    try {
        const rtn = await query(`SELECT count(*) as count from RECIPE;`)
        ctx.body = rtn[0]
    } catch (e) {
        ctx.status = 400;
        console.log(e)
        ctx.body = {
            error: e.toString()
        };
    }
})
.get('/recipe/filter/:ingredient', async (ctx, next) => {
    try {
        console.log(ctx.params)
        result = await query(`SELECT * from RECIPE where \`IN\` like '%${ctx.params.ingredient}%';`) //TODO: avoid inject
        // if (result.length == 0) {
        //     throw "not found"
        // }
        ctx.body = result
    } catch (e) {
        ctx.status = 400;
        console.log(e)
        ctx.body = {
            error: e.toString()
        };
    }
})
.get('/recipe/id/:bfk', async (ctx, next) => {
    try {
        console.log(ctx.params)
        result = await query(`SELECT * from RECIPE where \`blic Food Key\` = '${ctx.params.bfk}' ;`) //TODO: avoid inject
        let recipe = {}
        result.forEach((item) =>{
            if (recipe.id == null) {
                recipe.id = ctx.params.bfk
            }
            if (recipe.name == null) {
                recipe.name = item['Food Name']
                recipe.variants = []
            }
            delete item['Food Name']
            delete item['blic Food Key']
            recipe.variants.push(item)
        })
        console.log(recipe)
        ctx.body = recipe
    } catch (e) {
        ctx.status = 400;
        console.log(e)
        ctx.body = {
            error: e.toString()
        };
    }
})
.get('/recipe/id/:bfk/:ipfk', async (ctx, next) => {
    try {
        console.log(ctx.params)
        result = await query(`SELECT * from RECIPE where 'blic Food Key' = '${ctx.params.bfk}' and IPFK = '${ctx.params.ipfk}' ;`) //TODO: avoid inject
        // if (result.length == 0) {
        //     throw "not found"
        // }
        ctx.body = result[0]
    } catch (e) {
        ctx.status = 400;
        console.log(e)
        ctx.body = {
            error: e.toString()
        };
    }
})
.get('/nutritions', async (ctx, next) => {
    try {
        console.log(ctx.params)
        const rtn = await query('SELECT * from NUTRITION;')
        ctx.body = rtn
    } catch (e) {
        ctx.status = 400;
        console.log(e)
        ctx.body = {
            error: e.toString()
        };
    }
})
.get('/search/suggestions', async (ctx, next) => {
    console.log(ctx.params)
    rtn = await query(`SELECT \`Food Name\` from RECIPE;`) //TODO: avoid inject
    //TODO: add nu results
    //TODO: add cache for results
    let recipes = []
    rtn.forEach((item) =>{
        recipes.push({
            name: item['Food Name'].split(',')[0].trim(),
            fullname: item['Food Name'],
        })
    })
    ctx.body = recipes
})

app
.use(cors())
.use(router.routes())
.use(router.allowedMethods());
app.listen(4000);
