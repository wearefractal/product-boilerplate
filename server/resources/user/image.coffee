findUser = require './findById'

module.exports = (user, opt, cb) ->
  findUser user, opt, (err, data) ->
    return cb err if err?
    opt._res.redirect 302, "https://graph.facebook.com/#{user.fbid}/picture?height=600&width=600&type=normal"
    cb()

module.exports.http =
  method: 'get'
  plural: false