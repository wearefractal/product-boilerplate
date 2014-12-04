winston = require 'winston'
config = require './config'
server = require './http'

winston.log 'info', 'Starting with config', config

server.listen config.port, ->
  winston.log 'info', "Server running on #{config.port}"

module.exports = server
