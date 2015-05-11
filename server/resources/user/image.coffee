isObjectId = require '../../lib/isObjectId'
db = require '../../db'
{User} = db.models

defaultImage = 'http://www.gravatar.com/avatar/0?d=mm&f=y&s=600'

module.exports = (req, res, next) ->
  return res.status(403).end() unless req.isAuthenticated()
  return res.status(400).end() unless isObjectId req.params.id

  q = User.findById req.params.id
  q.exec (err, user) ->
    return next err if err?
    return res.status(404).end() unless user?
    res.redirect 302, "https://graph.facebook.com/#{user.fbid}/picture?height=600&width=600&type=normal"

module.exports.method = 'get'
