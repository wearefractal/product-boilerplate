async = require 'async'
goosestrap = require 'goosestrap'
{join} = require 'path'
config = require '../config'

modelDir = join __dirname, '../models/*'

db = goosestrap config.database, modelDir

db.wipe = (cb) ->
  fns = db.modelNames()
  fns = fns.map (k) -> db.model k
  fns = fns.map (m) ->
    return (done) ->
      m.remove ->
        m.collection.dropAllIndexes ->
          done()

  async.parallel fns, cb
  return db

db.dump = (modelName, cb) ->
  if typeof modelName is "string"
    Model = db.model modelName
  else
    Model = modelName
  Model.find {}, cb
  return db

db.import = (modelName, models, cb) ->
  if typeof modelName is "string"
    Model = db.model modelName
  else
    Model = modelName
  async.map models, Model.create.bind(Model), cb
  return db

module.exports = db