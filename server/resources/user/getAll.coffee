isObjectId = require '../../lib/isObjectId'
db = require '../../db'
User = db.model 'User'

module.exports = (req, res, next) ->
  #return res.status(403).end() unless req.isAuthenticated()

  q = User.find()
  q.select '-token'
  #q.limit 20

  q.exec (err, users) ->
    return next err if err?
    res.send users