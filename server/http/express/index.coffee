express = require 'express'

compress = require 'compression'
methodOverride = require 'method-override'
cookieParser = require 'cookie-parser'
errorHandler = require 'errorhandler'
bodyParser = require 'body-parser'
session = require 'express-session'

log = require '../../lib/log'
sessionStore = require './sessionStore'
config = require '../../config'

app = express()
app.disable 'x-powered-by'

app.use errorHandler()
app.use compress()
app.use methodOverride()
app.use bodyParser.json
  strict: true
  limit: '10mb'
app.use cookieParser config.cookieSecret

app.use session
  store: sessionStore
  key: config.cookieName
  secret: config.cookieSecret
  resave: false
  saveUninitialized: false
  cookie:
    maxAge: 31536000000

app.use (err, req, res, next) ->
  log.fatal err.stack
  res.send 500, 'Something broke!'

module.exports = app
