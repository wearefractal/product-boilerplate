cc = require 'config-chain'
{join} = require 'path'
{argv} = require 'optimist'
env = argv.env or process.env.NODE_ENV or 'development'

configWithEnv = join __dirname, "#{env}.json"
configDefault = join __dirname, 'default.json'
logFile = join __dirname, "#{env}.log"

hardcoded =
  logFile: logFile
  port: process.env.PORT
  database: process.env.MONGO_URL

# stupid fucking hack because config-chain sucks dick
delete hardcoded[k] for k,v of hardcoded when !v?

conf = cc argv, cc.env('app_'), hardcoded, configWithEnv, configDefault

out = conf.snapshot
delete out.$0

# computed config here
out.pubdir = join __dirname, '../../public'

module.exports = out
