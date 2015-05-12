{join} = require 'path'
staticFiles = require 'serve-static'
app = require './'
config = require '../../config'
idxFile = join config.pubdir, 'index.html'

if config.env is 'local'
  app.use staticFiles config.pubdir

app.get '/*', (req, res) ->
  res.sendFile idxFile

module.exports = app
