app = require './'
db = require '../../db'
config = require '../../config'
{join} = require 'path'
idxFile = join config.pubdir, 'index.html'

# page.js crap
app.get '/*', (req, res) ->
  res.sendFile idxFile

module.exports = app
