isObjectId = require '../../lib/isObjectId'
db = require '../../db'
{User} = db.models

module.exports = (user, opt, cb) ->
  unless user?
    return cb
      status: 403
      error: 'Not logged in'

  return cb status: 400 unless isObjectId opt.id
  return cb status: 403 unless opt.id is String(user._id)

  user.set 'deactivated', true
  user.save (err) ->
    return cb err if err?
    opt._req.logout()
    opt._res.redirect '/'
    cb()