isObjectId = require '../../lib/isObjectId'
log = require '../../lib/log'
db = require '../../db'
sendError = require '../../lib/sendError'
{User} = db.models

canModify = [
  'gender', 'birthday',
  'bio', 'location'
]

writeChanges = (user, changes, req, res) ->
  user.set changes
  user.set 'firstLogin', false
  user.save (err, nuser) ->
    return sendError res, err if err?
    res.json nuser.format ['self']

module.exports = (req, res, next) ->
  return res.status(403).end() unless req.isAuthenticated()
  return res.status(400).end() unless isObjectId req.params.id
  return res.status(403).end() unless req.params.id is String(req.user._id)
  return next new Error 'Invalid body' unless typeof req.body is 'object'

  # dont allow modification of reserved fields
  # canModify is the whitelist here
  delete req.body[k] for k, v of req.body when !~canModify.indexOf k
  q = User.findById req.params.id
  q.exec (err, user) ->
    return next err if err?

    writeChanges user, req.body, req, res
