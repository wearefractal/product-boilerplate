isObjectId = require '../../lib/isObjectId'
db = require '../../db'
{User} = db.models

module.exports = (user, opt, cb) ->
  unless user?
    return cb
      status: 403
      error: 'Not logged in'

  if isObjectId opt.id
    q = User.findById opt.id
  else
    q = User.findOne shortId: opt.id
  q.where 'deactivated', false
  q.exec (err, user) ->
    return cb err if err?
    return cb status: 404 unless user?

    cb null,
      status: 200
      result: user.format()