User = require './models/User'

if window._auth
  module.exports = new User window._user
else
  module.exports = null