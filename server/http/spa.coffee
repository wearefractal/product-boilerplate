fs = require 'fs'
app = require './express'
config = require '../config'
{join} = require 'path'

idxFile = join config.pubdir, "index.html"

# page.js crap
app.get '/*', (req, res) ->
  res.sendfile idxFile

module.exports = app