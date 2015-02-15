db = require '../../db'
User = db.model 'User'

module.exports = (user, done) ->
  unless user?
    return done 'window._auth = false;'

  str = JSON.stringify user.format('self'), null, 2
  src = "window._auth = true;\n"
  src += "window._user = #{str};"
  done src
