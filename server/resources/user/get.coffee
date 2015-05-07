isObjectId = require '../../lib/isObjectId'
db = require '../../db'
{User} = db.models

module.exports = (req, res, next) ->
  return res.status(403).end() unless req.isAuthenticated()
  return next new Error('Invalid id parameter') unless typeof req.params.id is 'string'

  q = User.findById req.params.id

  q.exec (err, user) ->
    return next err if err?
    return res.status(404).end() unless user?

    res.json user.format()
