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
    database: 'iteration3'
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
const getImgSrcsFromContent = (content) => {
    matchSrcs = []
    while ((arr = regexImgSrc.exec(content)) != null) {
        matchSrcs.push(arr[1])
    }
    return matchSrcs
}

const recipeFilterBuilder = (types, allergies, maxCal, minAge) => {
    const typeFilters = []
    const allergyFilters = [] // 84, 24, 49, 10, 56, 35, 41, 20
    let filter = []
    if (types.length > 0) {
        types.split(',').forEach((type) => {
            typeFilters.push(`Find_In_Set(${type}, TypeIds)`)
        })

        filter.push(typeFilters.join(' OR '))
    }

    if (allergies.length > 0) {
        allergies.split(',').forEach((allergy) => {
            allergyFilters.push(`NOT Find_In_Set(${allergy}, IngredientIds)`)
        })

        filter.push(allergyFilters.join(' AND '))
    }

    if (maxCal) {
        filter.push(`CalorieLevel <= ${maxCal}`)
    }

    if (minAge) {
        filter.push(`MinAge >= ${minAge}`)
    }

    if (filter.length > 0) { return "HAVING " + filter.join(" AND ") }
    else { return "" }
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
    .get('/search/suggestions', async (ctx, next) => {
        try {
            await syncFeeds()

            console.log(ctx.params)
            const recipes = await query(`SELECT \`RecipeName\` from RECIPE;`) //TODO: avoid inject
            //TODO: add nu results
            //TODO: add cache for results
            let rtn = []
            recipes.forEach((item) => {
                rtn.push({
                    type: 'food',
                    name: item['RecipeName'].split(',')[0].trim(),
                    fullname: item['RecipeName'],
                })
            })
            // process.feedItems.forEach((feedItem) => {
            //     rtn.push({
            //         type: 'news',
            //         name: feedItem.title,
            //         fullname: feedItem.title,
            //     })
            // })

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
    .get('/recipes', async (ctx, next) => {
        try {
            console.log(ctx.params, ctx.request.query)

            const offset = parseInt(ctx.request.query.offset) || 0
            const count = parseInt(ctx.request.query.count) || 12

            const types = ctx.request.query.types || ""
            const allergies = ctx.request.query.allergies || ""
            const maxCal = parseInt(ctx.request.query.max_cal) || null
            const minAge = parseInt(ctx.request.query.min_age) || null

            const sort = ctx.request.query.sort == "alphabet" ?
                "RecipeName" :
                ctx.request.query.sort == "calorie" ?
                    "CalorieLevel" : "RecipeId"

            const filter = recipeFilterBuilder(types, allergies, maxCal, minAge)

            results = await query(`
        SELECT
            RecipeId,
            RecipeName,
            CookingId,
            MinAge,
            CalorieLevel,
            CookingId,
            Details,
            CookingTime,
            GROUP_CONCAT(DISTINCT TypeId) as TypeIds,
            GROUP_CONCAT(DISTINCT TypeName) as TypeNames,
            GROUP_CONCAT(DISTINCT IngredientId) as IngredientIds,
            GROUP_CONCAT(DISTINCT IngredientName SEPARATOR '|') as IngredientNames,
            GROUP_CONCAT(Amount) as Amounts
        FROM
            Recipe
        NATURAL JOIN CookingStep NATURAL JOIN Recipe_Ingredient NATURAL JOIN Recipe_Type NATURAL JOIN Ingredient NATURAL JOIN Type GROUP BY RecipeId
        ${filter} ORDER BY ${sort}
        LIMIT ${offset}, ${count};`)

            recipes = []
            results.forEach((row) => {
                recipes.push({
                    RecipeId: row.RecipeId,
                    RecipeName: row.RecipeName,
                    CookingId: row.CookingId,
                    MinAge: row.MinAge,
                    CalorieLevel: row.CalorieLevel,
                    CookingId: row.CookingId,
                    Details: row.Details,
                    CookingTime: row.CookingTime,
                    TypeIds: row.TypeIds.split(','),
                    TypeNames: row.TypeNames.split(','),
                    IngredientIds: row.IngredientIds.split(','),
                    IngredientNames: row.IngredientNames.split('|'),
                    Amounts: row.Amounts.split(','),
                })
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
    .get('/recipes/count', async (ctx, next) => {
        try {
            const types = ctx.request.query.types || ""
            const allergies = ctx.request.query.allergies || ""
            const maxCal = parseInt(ctx.request.query.max_cal) || null
            const minAge = parseInt(ctx.request.query.min_age) || null

            const filter = recipeFilterBuilder(types, allergies, maxCal, minAge)

            const rtn = await query(`        
            SELECT count(*) as count from (
                SELECT
                    RecipeId,
                    RecipeName,
                    CookingId,
                    MinAge,
                    CalorieLevel,
                    Details,
                    CookingTime,
                    GROUP_CONCAT(DISTINCT TypeId) as TypeIds,
                    GROUP_CONCAT(DISTINCT TypeName) as TypeNames,
                    GROUP_CONCAT(DISTINCT IngredientId) as IngredientIds,
                    GROUP_CONCAT(DISTINCT IngredientName SEPARATOR '|') as IngredientNames,
                    GROUP_CONCAT(DISTINCT Amount) as Amounts
                FROM
                    Recipe
                NATURAL JOIN CookingStep NATURAL JOIN Recipe_Ingredient NATURAL JOIN Recipe_Type NATURAL JOIN Ingredient NATURAL JOIN Type GROUP BY RecipeId
                ${filter}
            ) as Recipe;
        `)
            ctx.body = rtn[0]
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/recipes/types/count', async (ctx, next) => {
        try {
            const rtn = await query(`        
            SELECT
                TypeId,
                TypeName,
                count(RecipeId) as count
            FROM
                Recipe
            NATURAL JOIN Recipe_Type NATURAL JOIN Type GROUP BY TypeId;
        `)
            ctx.body = rtn
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/recipes/types', async (ctx, next) => {
        try {
            const rtn = await query(`SELECT * from Type;`)
            ctx.body = rtn
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/ingredients', async (ctx, next) => {
        try {
            const ids = ctx.request.query.ids

            let filter = ""

            if (ids) {
                filter = `where IngredientId in (${ctx.request.query.ids})`
            }

            const rtn = await query(`SELECT * from Ingredient ${filter};`)
            ctx.body = rtn
        } catch (e) {
            ctx.status = 400;
            console.log(e)
            ctx.body = {
                error: e.toString()
            };
        }
    })
    .get('/recipe/:id', async (ctx, next) => {
        try {
            console.log(ctx.params)

            const results = await query(`
        SELECT
            RecipeId,
            RecipeName,
            CookingId,
            MinAge,
            CalorieLevel,
            CookingId,
            Details,
            CookingTime,
            GROUP_CONCAT(DISTINCT TypeId) as TypeIds,
            GROUP_CONCAT(DISTINCT TypeName) as TypeNames,
            GROUP_CONCAT(DISTINCT IngredientId) as IngredientIds,
            GROUP_CONCAT(DISTINCT IngredientName SEPARATOR '|') as IngredientNames,
            GROUP_CONCAT(DISTINCT CONCAT(IngredientId, '|' ,Amount)) as Amounts
        FROM
            Recipe
        NATURAL JOIN CookingStep NATURAL JOIN Recipe_Ingredient NATURAL JOIN Recipe_Type NATURAL JOIN Ingredient NATURAL JOIN Type
        GROUP BY RecipeId
        HAVING RecipeId = ${ctx.params.id}`)
            const result = results[0]
            ctx.body = {
                RecipeId: result.RecipeId,
                RecipeName: result.RecipeName,
                CookingId: result.CookingId,
                MinAge: result.MinAge,
                CalorieLevel: result.CalorieLevel,
                CookingId: result.CookingId,
                Details: result.Details,
                CookingTime: result.CookingTime,
                TypeIds: result.TypeIds.split(','),
                TypeNames: result.TypeNames.split(','),
                IngredientIds: result.IngredientIds.split(','),
                IngredientNames: result.IngredientNames.split('|'),
                Amounts: result.Amounts.split(',').map((v) => v.split('|')[1]),
            }
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
app.listen(6000);
