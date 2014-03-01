isObjectId = require '../../lib/isObjectId'
db = require '../../db'
User = db.model 'User'

module.exports = (req, res, next) ->
  #return res.status(403).end() unless req.isAuthenticated()
  return next new Error('Invalid id parameter') unless typeof req.params.id is 'string'

  if isObjectId req.params.id
    # look up by db id
    q = User.findById req.params.id
    isOwner = req.user? and (String(req.user._id) is req.params.id)
  else
    # look up by fb username/id
    q = User.findOne
      $or: [
        username: req.params.id
      ,
        fbid: req.params.id
      ]
    isOwner = req.user? and (String(req.user.username) is req.params.id or String(req.user.fbid) is req.params.id)

  q.exec (err, user) ->
    return next err if err?
    return res.status(404).end() unless user?

    user = user.toJSON()

    # security
    unless isOwner
      delete user.token

    res.send user
