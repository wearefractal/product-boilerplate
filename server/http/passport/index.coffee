passport = require 'passport'
config = require '../../config'
app = require '../express'
createAuthScript = require './createAuthScript'
db = require '../../db'
{User} = db.models

app.use passport.initialize()
app.use passport.session()

app.get '/auth/logout', (req, res) ->
  req.logout()
  res.redirect '/'

app.get '/auth.js', (req, res) ->
  createAuthScript req.user, (src) ->
    res.set 'Content-Type', 'application/javascript'
    res.status 200
    res.send src

module.exports = passport
