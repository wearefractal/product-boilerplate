{Schema} = require 'mongoose'
format_fields = require 'mongoose-format-fields'
calcAge = require '../lib/calcAge'

Model = new Schema
  role:
    grants: ['admin']
    type: String
    enum: ['pleb', 'admin']
    default: 'pleb'

  # fb fields
  fbid:
    grants: ['admin', 'self']
    type: String
    required: true

  email:
    grants: ['admin', 'self']
    type: String

  token:
    grants: ['admin']
    type: String

  name:
    grants: ['admin', 'self']
    type: String
    required: true

  first_name:
    grants: 'public'
    type: String
    required: true

  last_name:
    grants: ['admin', 'self']
    type: String
    required: true

  gender:
    grants: 'public'
    type: String
    lowercase: true
    enum: ['female', 'male']

  timezone:
    grants: ['admin', 'self']
    type: Number

  locale:
    grants: ['admin', 'self']
    type: String

  verified:
    grants: ['admin']
    type: Boolean

  location:
    grants: 'public'
    type: String
    maxlength: 100

  bio:
    grants: 'public'
    type: String
    maxlength: 140

  birthday:
    grants: ['admin', 'self']
    type: Date

  # datetime markers
  created:
    grants: ['admin']
    type: Date
    default: Date.now

  lastModified:
    grants: ['admin']
    type: Date
    default: Date.now

  firstLogin:
    grants: 'public'
    type: Boolean
    default: true

  lastLogin:
    grants: 'public'
    type: Date
    default: Date.now

Model.virtual('finishedSetup').get ->
  @age? and @gender? and @location?

Model.virtual('image').get ->
  return "/v1/users/#{@id}/image"

Model.virtual('age').get ->
  return null unless @birthday?
  return calcAge @birthday

Model.path('birthday').validate (value, next) ->
  age = calcAge @birthday
  return next new Error('You must be 18 or older to use glance') unless age >= 18
  return next new Error('You must be 55 or younger to use glance') unless age <= 55
  next()

Model.pre 'save', (next) ->
  @lastModified = Date.now()
  next()

Model.set 'id_grants', 'public'
Model.set 'id_output', 'id'
Model.set 'toJSON',
  getters: true
  virtuals: true
Model.set 'toObject',
  getters: true
  virtuals: true
Model.set 'strict', true
Model.plugin format_fields

module.exports = Model
