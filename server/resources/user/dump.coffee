map = require 'lodash.map'
isObjectId = require '../../lib/isObjectId'
csv = require 'to-csv'
db = require '../../db'
{User} = db.models

module.exports = (req, res, next) ->
  return res.status(403).end() unless req.isAuthenticated()
  return res.status(403).end() unless req.user.role is 'admin'

  q = User.find()
  q.exec (err, users) ->
    return next err if err?
    res
      .status(200)
      .attachment('users.csv')
      .send csv map users, (v) ->
        email: v.email
        name: v.name
        age: v.age
        location: v.location
        bio: v.bio
        lookingFor: v.lookingFor
        gender: v.gender
        lastLogin: v.lastLogin
        created: v.created
        finishedSetup: v.finishedSetup

module.exports.standalone = true
module.exports.method = 'get'
