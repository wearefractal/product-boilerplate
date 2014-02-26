isObjectId = require '../../lib/isObjectId'
db = require '../../db'
async = require 'async'
Comment = db.model 'Comment'

maxLimit = 100

filter = (comment, cb) ->
  ncomment = comment.toJSON()
  if ncomment.from?
    delete ncomment.from.token
    delete ncomment.from.__v
  cb null, ncomment

module.exports = (req, res, next) ->
  return res.status(400).end() unless req.query.from or req.query.to

  limit = parseInt(req.query.limit, 10) or maxLimit
  skip = parseInt(req.query.skip, 10) or 0

  if limit > maxLimit
    return res.status(400).send(error: "Max limit is #{maxLimit}").end()

  q = Comment.find()
  q.populate 'from'
  q.sort '-created'
  q.limit limit
  q.skip skip

  if req.query.to
    q.where 'to', req.query.to
  if req.query.from
    q.where 'from', req.query.from

  q.exec (err, comments) ->
    return next err if err?

    async.map comments, filter, (err, filtered) ->
      return next err if err?
      res.send filtered