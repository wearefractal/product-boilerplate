db = require '../database'
User = db.model 'User'
passport = require "passport"
config = require '../config'
app = require './express'
express = require 'express'

app.use passport.initialize()
app.use passport.session()

app.get '/logout', (req, res) ->
  req.logout()
  res.redirect '/'

app.get '/js/loggedIn.js', (req, res) ->
  src = "window._loggedIn = #{req.isAuthenticated()};"
  if req.user
    src += "\r\nwindow._loggedInId = \"#{req.user._id}\";"

  res.set 'Content-Type', 'application/javascript'
  res.send 200, src

module.exports = passport