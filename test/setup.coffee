passport = require 'passport'
mongoose = require 'mongoose'

db = require '../server/database'
config = require '../server/config'

User = db.model 'User'

should = require 'should'
require 'mocha'

originalInit = passport.initialize()

hooked = false
hookedInit = (req, res, next) ->
  return originalInit req, res, next unless hooked and req.query._user
  req._passport = instance: passport

  User.findById String(req.query._user), (err, user) ->
    return next err if err?
    req._passport.session = user: user
    next()

passport.initialize = -> hookedInit

setup =
  db: db
  newId: -> String mongoose.Types.ObjectId()

  user:
    createQuery: (id) -> _user: id
    create: (cb) ->
      mock =
        _id: setup.user.id
        id: 1234567
        name: "Mike Adams"
        first_name: "Mike"
        last_name: "Adams"
        token: "sofake"
        username: "mikeadams"
        
      User.create mock, cb

  passport:
    hook: -> hooked = true
    unhook: -> hooked = false

setup.user.id = setup.newId()
module.exports = setup