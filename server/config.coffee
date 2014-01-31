cc = require 'config-chain'
{join} = require 'path'
{argv} = require 'optimist'
env = argv.env or process.env.NODE_ENV or 'development'

configWithEnv = join __dirname, './config/', "#{env}.json"
configDefault = join __dirname,  './config/', 'default.json'
logFile = join __dirname, './logs/', "#{env}.log"

conf = cc argv, cc.env('app_'), configWithEnv, configDefault, {logFile: logFile}

out = conf.snapshot
delete out.$0

# computed config here
out.pubdir = join __dirname, '../public'

module.exports = out