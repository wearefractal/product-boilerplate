app = require './express'
config = require '../config'
http = require 'http'
fs = require 'fs'

server = http.createServer(app).listen config.port

module.exports = server