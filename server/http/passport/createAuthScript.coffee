db = require '../../db'
User = db.model 'User'

module.exports = (user, done) ->
  unless user?
    return done 'window._auth = false;'

  User
  .findById user._id
  .populate 'friends'
  .exec (err, user) ->
    str = JSON.stringify user, null, 2
    src = "window._auth = true;\n"
    src += "window._user = #{str};"
    done src
