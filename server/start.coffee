winston = require 'winston'
config = require './config'

winston.log 'info', 'Starting with config', config

db = require './db'

app = require './http/express'
auth = require './http/passport'
fbauth = require './http/passport-facebook'
apis = require './http/apis'
spa = require './http/spa'

httpServer = require './http/httpServer'

winston.log 'info', "Server running on #{config.port}"

module.exports = app