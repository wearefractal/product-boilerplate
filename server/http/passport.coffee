db = require '../db'
User = db.model 'User'
passport = require 'passport'
config = require '../config'
app = require './express'
createAuthScript = require '../lib/createAuthScript'

app.use passport.initialize()
app.use passport.session()

app.get '/logout', (req, res) ->
  req.logout()
  res.redirect '/'

app.get '/auth.js', (req, res) ->
  src = createAuthScript req.user
  res.set 'Content-Type', 'application/javascript'
  res.send 200, src

module.exports = passport