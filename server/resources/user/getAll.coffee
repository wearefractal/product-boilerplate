isObjectId = require '../../lib/isObjectId'
db = require '../../db'
{User} = db.models

module.exports = (req, res, next) ->
  return res.status(403).end() unless req.isAuthenticated()

  q = User.find()
  q.select '-token'

  q.exec (err, users) ->
    return next err if err?
    res.json users.map (u) ->
      return u.format()
