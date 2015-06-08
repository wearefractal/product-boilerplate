map = require 'lodash.map'
csv = require 'to-csv'
db = require '../../db'
{User} = db.models

formatUser = (v) ->
  email: v.email
  name: v.name
  age: v.age
  location: v.location
  lastLogin: v.lastLogin
  created: v.created
  needsSetup: v.needsSetup

module.exports = (user, opt, cb) ->
  unless user?
    return cb
      status: 403
      error: 'Not logged in'
  return cb status: 403 unless user.role is 'admin'

  q = User.find()
  q.exec (err, users=[]) ->
    return cb err if err?
    opt._res
      .status(200)
      .attachment('users.csv')
      .send csv map users, formatUser
    cb()

module.exports.http =
  method: 'get'
  plural: true