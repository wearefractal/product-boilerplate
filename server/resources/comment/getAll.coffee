isObjectId = require '../../lib/isObjectId'
db = require '../../db'
Comment = db.model 'Comment'

maxLimit = 100

module.exports = (req, res, next) ->
  return res.status(400).end() unless req.query.from or req.query.to

  limit = parseInt(req.query.limit, 10) or maxLimit
  skip = parseInt(req.query.skip, 10) or 0

  if limit > maxLimit
    return res.status(400).send(error: "Max limit is #{maxLimit}").end()

  q = Comment.find()
  q.limit limit
  q.skip skip

  if req.query.to
    q.where 'to', req.query.to
  if req.query.from
    q.where 'from', req.query.from

  q.exec (err, comments) ->
    return next err if err?
    res.send comments