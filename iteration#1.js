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
    database: 'Iteration1'
}
const pool  = mysql.createPool(poolConfig)
const query = util.promisify(pool.query).bind(pool);

router
.get('/recipes', async (ctx) => {
    try {
        const rtn = await query('SELECT * from Recipe natural join Recipe_Ingredient natural join Ingredient natural join CookingStep natural join RecipeType;')
        let recipes = {}
        rtn.forEach((item) =>{
            if (recipes[item.RecipeName] == null) recipes[item.RecipeName] = {id: item.RecipeId, name: item.RecipeName, type: item.TypeName, details: item.Details, ingredients: new Set()}
            let ingredients = new Set(recipes[item.RecipeName].ingredients)
            ingredients.add(item.IngredientName)
            recipes[item.RecipeName].ingredients = Array.from(ingredients)
        })
        ctx.body = recipes
    } catch (e) {
        ctx.status = 400;
        console.log(e)
        ctx.body = {
            error: e.toString()
        };
    }
})
.get('/recipe', async (ctx, next) => {
    try {
        console.log(ctx.request.query)
        result = await query(`SELECT * from Recipe where RecipeID=${ctx.request.query.id};`)
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

app
.use(cors())
.use(router.routes())
.use(router.allowedMethods());
app.listen(4000);
