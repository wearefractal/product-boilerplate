{Schema} = require 'mongoose'
formatFields = require 'mongoose-format-fields'

Model = new Schema
  # fb fields
  fbid:
    grants: ['admin', 'self']
    type: String
    required: true
    index:
      unique: true

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

  token:
    grants: ['admin', 'self']
    type: String
    required: true

  gender:
    grants: 'public'
    type: String
    lowercase: true

  timezone:
    grants: ['admin', 'self']
    type: Number

  locale:
    grants: ['admin', 'self']
    type: String

  verified:
    grants: ['admin', 'self']
    type: Boolean

  location:
    grants: 'public'
    type: String
    default: 'Earth'

  bio:
    grants: 'public'
    type: String

  created:
    grants: ['admin', 'self']
    type: Date
    default: Date.now

  lastModified:
    grants: ['admin', 'self']
    type: Date
    default: Date.now

  # custom fields here
  phone:
    grants: ['admin', 'self']
    type: String
    validate: /^\d{10}$/
    unique: true

Model.virtual('image').get ->
  return "http://graph.facebook.com/#{@fbid}/picture?height=800&type=normal&width=800"

Model.set 'toJSON',
  getters: true
  virtuals: true

Model.set 'toObject',
  getters: true
  virtuals: true
Model.set 'strict', true

Model.pre 'save', (next) ->
  @lastModified = Date.now()
  next()

Model.set 'id_grants', 'public'
Model.set 'id_output', 'id'
Model.plugin formatFields

module.exports = Model
