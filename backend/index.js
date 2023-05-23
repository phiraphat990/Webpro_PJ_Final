const express = require("express")

const app = express();
const cors = require('cors')

const { logger } = require('./middlewares')
app.use(logger)

app.use(cors())

// Statics
app.use(express.static('static'))
app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

// routers
const indexRouter = require('./routes/index')
const blogRouter = require('./routes/blog')
const commentRouter = require('./routes/comment')
const imageRouter = require('./routes/image')
const userRouter = require('./routes/user')
//ใหม่
const manageRouter = require('./routes/manage')
const productRouter = require('./routes/product')
const cartRouter = require('./routes/cart')
const orderRouter = require('./routes/order')


app.use(indexRouter.router)
app.use(blogRouter.router)
app.use(commentRouter.router)
app.use(imageRouter.router)
app.use(userRouter.router)
//ใหม่
app.use(manageRouter.router)
app.use(productRouter.router)
app.use(cartRouter.router)
app.use(orderRouter.router)

app.listen(3000, () => {
  console.log(`Example app listening at http://localhost:3000`)
})