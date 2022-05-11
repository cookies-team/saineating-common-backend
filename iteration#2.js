const Koa = require('koa');
const Router = require('@koa/router');
const cors = require('@koa/cors');
const util = require('util');
const app = new Koa();
const router = new Router();
let Parser = require('rss-parser');
let rssParser = new Parser();

const mysql = require('mysql');
const { match } = require('assert');
const poolConfig = {
    connectionLimit: 10,
    socketPath: '/var/run/mysqld/mysqld.sock',
    user: 'admin',
    password: 'icaneatglass',
    database: 'Iteration2'
}
const pool = mysql.createPool(poolConfig)
const query = util.promisify(pool.query).bind(pool);

const feedSrcs = [
    'https://www.skinnytaste.com/feed/',
    'http://feeds.101cookbooks.com/101cookbooks'
]
let lastSyncTime = 0
process.feedItems = null

const regexImgSrc = /src="([^"]+)"/gm
function getImgSrcsFromContent(content) {
    matchSrcs = []
    while ((arr = regexImgSrc.exec(content)) != null) {
        matchSrcs.push(arr[1])
    }
    return matchSrcs
}

async function syncFeeds() {
    const now = Date.now() / 1000 | 0
    if (now > lastSyncTime + 3600 || process.feedItems == null) {
        console.log("updateing feeds")
        lastSyncTime = now
        let _feedItems = []
        await Promise.all(feedSrcs.map(async (src) => {
            let rss = await rssParser.parseURL(src);
            rss.items.forEach((item) => {
                srcs = getImgSrcsFromContent(item['content:encoded'])
                item['srcs'] = srcs
                _feedItems.push(item)
            })
        }))

        process.feedItems = _feedItems
    }
}

router
    .get('/recipes', async (ctx, next) => {
        try {
            const offset = parseInt(ctx.request.query.offset) || 0
            const count = parseInt(ctx.request.query.count) || 12

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
            result.forEach((item) => {
                if (recipe.id == null) {
                    recipe.id = ctx.params.bfk
                }
                if (recipe.name == null) {
                    recipe.name = item['Food Name']
                    recipe.dishes = []
                }
                delete item['Food Name']
                delete item['blic Food Key']
                recipe.dishes.push(item)
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
        try {
            await syncFeeds()

            console.log(ctx.params)
            const recipes = await query(`SELECT \`Food Name\` from RECIPE;`) //TODO: avoid inject
            //TODO: add nu results
            //TODO: add cache for results
            let rtn = []
            recipes.forEach((item) => {
                rtn.push({
                    type: 'food',
                    name: item['Food Name'].split(',')[0].trim(),
                    fullname: item['Food Name'],
                })
            })
            process.feedItems.forEach((feedItem) => {
                rtn.push({
                    type: 'news',
                    name: feedItem.title,
                    fullname: feedItem.title,
                })
            })

            ctx.body = rtn
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/feeds', async (ctx, next) => {
        try {
            await syncFeeds()

            const offset = parseInt(ctx.request.query.offset) || 0
            const count = parseInt(ctx.request.query.count) || 12
            // _feeds.items.sort((a, b) => {
            //     Date(a.isoDate) - Date(b.isoDate)
            // })
            rtn = { items: process.feedItems.slice(offset, Math.min(offset + count, process.feedItems.length)) }
            ctx.body = rtn
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/feeds/count', async (ctx, next) => {
        try {
            await syncFeeds()

            ctx.body = { count: process.feedItems.length }
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/restaurants', async (ctx, next) => {
        try {
            console.log(ctx.params)
            result = await query(`SELECT * from Restaurant join Type on Restaurant.RestTypeId = Type.TypeId;`)

            ctx.body = result
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/recipes_v2', async (ctx, next) => {
        try {
            console.log(ctx.params)

            const offset = parseInt(ctx.request.query.offset) || 0
            const count = parseInt(ctx.request.query.count) || 12

            filter = ""
            if (ctx.request.query.type) {
                filter += `TypeName=${ctx.request.query.type}`
            } // can add more filter
            if (filter.length > 0) filter = "where " + filter
            results = await query(`SELECT * from Recipe 
            natural join CookingStep 
            natural join Recipe_Ingredient 
            natural join Recipe_Type 
            natural join Ingredient 
            natural join Type 
            ${filter}
            ;`)

            recipes = []
            results.forEach((row) => {
                if (recipes[row.RecipeId] == null)
                    recipes[row.RecipeId] = {
                        id: row.RecipeId,
                        name: row.RecipeName,
                        cookingId: row.CookingId,
                        details: row.Details,
                        typeIds: [row.TypeID],
                        types: [row.TypeName],
                        ingredientIds: [row.IngredientId],
                        ingredients: [
                            {
                                id: row.IngredientId,
                                name: row.IngredientName,
                                amount: row.Amount,
                            }
                        ],
                    }
                else {
                    if (!recipes[row.RecipeId].typeIds.includes(row.TypeID)) {
                        recipes[row.RecipeId].typeIds.push(row.TypeID)
                        recipes[row.RecipeId].types.push(row.TypeName)
                    }

                    if (!recipes[row.RecipeId].ingredientIds.includes(row.IngredientId)) {
                        recipes[row.RecipeId].ingredientIds.push(row.IngredientId)
                        recipes[row.RecipeId].ingredients.push({
                            id: row.IngredientId,
                            name: row.IngredientName,
                            amount: row.Amount,
                        })
                    }

                }
            })


            if (ctx.request.query.sort == "alphabet") {
                recipes.sort((a, b) => {
                    a.name.localeCompare(b.name)
                })
            }

            ctx.body = recipes
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/recipes_v3', async (ctx, next) => {
        try {
            console.log(ctx.params, ctx.request.query)

            const offset = parseInt(ctx.request.query.offset) || 0
            const count = parseInt(ctx.request.query.count) || 12
            const sqlSort = ""
            let filter = ""

            if (ctx.request.query.type) {
                filter += `TypeName=${ctx.request.query.type}`
            } // can add more filter
            if (filter.length > 0) filter = "where " + filter
            
            results = await query(`
            SELECT * from (SELECT * from Recipe limit ${offset}, ${count})
                as Recipe
            natural join CookingStep 
            natural join Recipe_Ingredient 
            natural join Recipe_Type 
            natural join Ingredient 
            natural join Type
            ${filter}
            ${sqlSort}
            `)

            recipes = []
            results.forEach((row) => {
                if (recipes[row.RecipeId] == null)
                    recipes[row.RecipeId] = {
                        id: row.RecipeId,
                        name: row.RecipeName,
                        cookingId: row.CookingId,
                        details: row.Details,
                        typeIds: [row.TypeID],
                        types: [row.TypeName],
                        ingredientIds: [row.IngredientId],
                        ingredients: [
                            {
                                id: row.IngredientId,
                                name: row.IngredientName,
                                amount: row.Amount,
                            }
                        ],
                    }
                else {
                    if (!recipes[row.RecipeId].typeIds.includes(row.TypeID)) {
                        recipes[row.RecipeId].typeIds.push(row.TypeID)
                        recipes[row.RecipeId].types.push(row.TypeName)
                    }

                    if (!recipes[row.RecipeId].ingredientIds.includes(row.IngredientId)) {
                        recipes[row.RecipeId].ingredientIds.push(row.IngredientId)
                        recipes[row.RecipeId].ingredients.push({
                            id: row.IngredientId,
                            name: row.IngredientName,
                            amount: row.Amount,
                        })
                    }

                }
            })


            switch (ctx.request.query.sort) {
                case "alphabet":
                    recipes.sort((a, b) => {
                        a.name.localeCompare(b.name)
                    })
                default:
                    recipes.sort((a, b) => {
                        a.id < b.id
                    })
            }

            ctx.body = recipes.filter(e => {
                return e != null;
            });
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/recipe_v2/:id', async (ctx, next) => {
        try {
            console.log(ctx.params)

            results = await query(`SELECT * from Recipe natural join CookingStep 
                natural join Recipe_Ingredient 
                natural join Recipe_Type 
                natural join Ingredient 
                natural join Type 
                where RecipeId = ${ctx.params.id};`)

            recipe = null
            results.forEach((row) => {
                if (recipe == null)
                    recipe = {
                        id: row.RecipeId,
                        name: row.RecipeName,
                        cookingId: row.CookingId,
                        details: row.Details,
                        typeIds: [row.TypeID],
                        types: [row.TypeName],
                        ingredientIds: [row.IngredientId],
                        ingredients: [
                            {
                                id: row.IngredientId,
                                name: row.IngredientName,
                                amount: row.Amount,
                            }
                        ],
                    }
                else {
                    if (!recipe.typeIds.includes(row.TypeID)) {
                        recipe.typeIds.push(row.TypeID)
                        recipe.types.push(row.TypeName)
                    }
                    if (!recipe.ingredientIds.includes(row.IngredientId)) {
                        recipe.ingredientIds.push(row.IngredientId)
                        recipe.ingredients.push({
                            id: row.IngredientId,
                            name: row.IngredientName,
                            amount: row.Amount,
                        })
                    }
                }
            })


            ctx.body = recipe
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/recipes_v2/count', async (ctx, next) => {
        try {
            const rtn = await query(`SELECT count(*) as count from Recipe;`)
            ctx.body = rtn[0]
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
app.listen(5000);
