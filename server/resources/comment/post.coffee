isObjectId = require '../../lib/isObjectId'
db = require '../../db'
Comment = db.model 'Comment'

module.exports = (req, res, next) ->
  return res.status(403).end() unless req.isAuthenticated()
  return next new Error 'Invalid body' unless typeof req.body is 'object'

  # reserved fields
  delete req.body.from
  delete req.body.created
  req.body.from = req.user._id

  Comment.create req.body, (err, comment) ->
    return next err if err?
    res.json comment
