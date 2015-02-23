db = require '../../db'
User = db.model 'User'
passport = require 'passport'
ppfb = require 'passport-facebook'
FacebookStrategy = ppfb.Strategy
config = require '../../config'
app = require '../express'
express = require 'express'

# cherry pick fields of facebook json to make a user profile
profileToUser = (profile, accessToken) ->
  profile.fbid = profile.id
  profile.provider = 'facebook'
  profile.token = accessToken

  # field formatting
  profile.location = profile.location?.name

  # dont let fb overwrite our sacred vars
  delete profile.id
  delete profile._id
  return profile

# main login handler
handleLogin = (accessToken, refreshToken, profile, done) ->
  theoreticalUser = profileToUser profile._json, accessToken

  q = User.findOne fbid: theoreticalUser.fbid
  q.exec (err, user) ->
    return done err if err?
    if user?
      handleExistingLogin user, theoreticalUser, done
    else
      handleFirstLogin theoreticalUser, done

# login handler for users who have logged in before
handleExistingLogin = (user, theoreticalUser, cb) ->
  user.set theoreticalUser
  user.set 'firstLogin', false
  user.save cb

# login handler for users who have never logged in
handleFirstLogin = (theoreticalUser, cb) ->
  User.create theoreticalUser, cb

# serializing used for signed cookies
userToString = (user, cb) ->
  cb null, String user._id

stringToUser = (_id, cb) ->
  User.findById _id, cb

# internals to facebook login
strategyConfig =
  clientID: config.facebook.id
  clientSecret: config.facebook.secret
  callbackURL: config.facebook.callback
  scope: [
    'public_profile'
    'user_about_me'
    'user_interests'
    'user_activities'
    'user_location'
  ]

strategy = new FacebookStrategy strategyConfig, handleLogin

passport.use strategy
passport.serializeUser userToString
passport.deserializeUser stringToUser

app.get '/auth/facebook', passport.authenticate 'facebook',
  display: 'touch'

app.get '/auth/facebook/callback', passport.authenticate 'facebook',
  display: 'touch'
  successRedirect: '/setup'
  failureRedirect: '/'

module.exports = passport
