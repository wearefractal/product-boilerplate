db = require '../../db'
{User} = db.models

canModify = [
  'gender', 'birthday',
  'bio', 'location'
]

writeChanges = (user, changes, cb) ->
  user.set changes
  user.set 'firstLogin', false
  user.save (err, nuser) ->
    return cb err if err?
    return cb null, nuser.format ['self'] unless nuser.busy
    cb null, nuser.format ['self']

module.exports = (user, opt, cb) ->
  unless user?
    return cb
      status: 403
      error: 'Not logged in'
  return cb status: 403 unless opt.id is String(user._id)
  return cb status: 400 unless typeof opt.data is 'object'

  # dont allow modification of reserved fields
  # canModify is the whitelist here
  delete opt.data[k] for k, v of opt.data when !~canModify.indexOf k

  q = User.findById opt.id
  q.exec (err, user) ->
    return cb err if err?
    writeChanges user, opt.data, (err, data) ->
      return cb err if err?
      cb null,
        status: 200
        result: data