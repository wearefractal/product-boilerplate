config = require '../../config'

express = require 'express'

compress = require 'compression'
methodOverride = require 'method-override'
cookieParser = require 'cookie-parser'
responseTime = require 'response-time'
errorHandler = require 'errorhandler'
bodyParser = require 'body-parser'
staticFiles = require 'serve-static'
session = require 'express-session'
logger = require 'morgan'

sessionStore = require './sessionStore'

app = express()
app.disable 'x-powered-by'

if config.debug
  app.use logger 'dev'

app.use errorHandler()
app.use responseTime()
app.use compress()
app.use methodOverride()
app.use bodyParser.json strict: true
app.use cookieParser config.cookieSecret
app.use staticFiles config.pubdir

app.use (err, req, res, next) ->
  console.error err.stack
  res.send 500, 'Something broke!'

app.use session
  store: sessionStore
  key: config.cookieName
  secret: config.cookieSecret
  resave: false
  saveUninitialized: false
  cookie:
    maxAge: 31536000000

module.exports = app
