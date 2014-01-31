express = require 'express'
config = require '../config'
db = require '../database'

app = express()
app.use express.compress()
app.use express.methodOverride()
app.use express.bodyParser()
app.use express.cookieParser config.cookieSecret
if config.cache
  app.use express.staticCache()
app.use express.static config.pubdir

#mStore = new MongoStore
#  mongoose_connection: db
#  auto_reconnect: true

app.use express.session
  secret: config.cookieSecret
  maxAge: 31536000000
  #store: mStore

module.exports = app