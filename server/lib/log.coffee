fs = require 'fs'
{join} = require 'path'
bunyan = require 'bunyan'
PrettyStream = require 'bunyan-prettystream'
onFinished = require 'on-finished'

prettyStream = new PrettyStream()
prettyStream.pipe process.stdout

config = require '../config'

logStreams = [
  path: config.logs.file
,
  stream: prettyStream
  level: 'info'
]

logger = bunyan.createLogger
  name: config.name
  hostname: config.name
  serializers: bunyan.stdSerializers
  streams: logStreams

# stop logging output if testing
if config.env is 'testing'
  logger =
    info: ->
    error: ->
    fatal: ->

module.exports = logger
