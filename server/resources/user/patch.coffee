isObjectId = require '../../isObjectId'
db = require '../../database'
User = db.model 'User'

module.exports = (req, res, next) ->
  return res.status(403).end() unless req.isAuthenticated()
  return next new Error 'Invalid id parameter' unless isObjectId req.params.id
  return res.status(403).end() unless req.params.id is String(req.user._id)
  return next new Error 'Invalid body' unless typeof req.body is 'object'

  # reserved fields
  delete req.body.id
  delete req.body._id
  delete req.body.name
  delete req.body.first_name
  delete req.body.last_name
  delete req.body.token
  delete req.body.link
  delete req.body.username
  delete req.body.gender
  delete req.body.timezone
  delete req.body.locale
  delete req.body.verified
  delete req.body.location
  delete req.body.created
  delete req.body.lastModified

  # we only allow them to modify the roster attribute
  q = User.findById req.params.id
  q.exec (err, user) ->
    return next err if err?

    user.set req.body

    user.save (err, nuser) ->
      return next err if err?
      res.send nuser.toJSON()