# TODO: split this out
merge = require 'lodash.merge'
{join} = require 'path'
{argv} = require 'optimist'
env = argv.env or process.env.NODE_ENV or 'local'

configWithEnv = require "./#{env}"
configDefault = require './default'

conf = merge configDefault, configWithEnv

conf.name = "#{conf.name}-#{env}"
conf.logs ?= {}
conf.logs.file = "#{env}.log"
conf.env = env
conf.port = conf.port or process.env.PORT
conf.database = conf.database or process.env.MONGO_URL
conf.pubdir = join __dirname, '../../public'

# computed config here
module.exports = conf
