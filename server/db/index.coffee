goosestrap = require 'goosestrap'
{join} = require 'path'
config = require '../config'

modelDir = join __dirname, '../models/*'
db = goosestrap config.database, modelDir

module.exports = db