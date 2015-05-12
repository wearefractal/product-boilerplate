pmx = require('pmx').init()
log = require './lib/log'
config = require './config'

# Start server
server = require './http'
db = require './db'
{User} = db.models

server.listen config.port, ->
  log.info 'Server running on', config.port

process.on 'uncaughtException', (e) ->
  log.error e

module.exports = server
