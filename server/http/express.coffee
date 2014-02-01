express = require 'express'
config = require '../config'

app = express()
app.use express.compress()
app.use express.methodOverride()
app.use express.bodyParser()
app.use express.cookieParser config.cookieSecret
if config.cache
  app.use express.staticCache()
app.use express.static config.pubdir

app.use express.session
  secret: config.cookieSecret
  maxAge: 31536000000

module.exports = app