{Schema} = require 'mongoose'

User = new Schema
  # fb fields
  fbid:
    type: String
    required: true
    index:
      unique: true

  name:
    type: String
    required: true

  first_name:
    type: String
    required: true

  last_name:
    type: String
    required: true

  token:
    type: String
    required: true

  link:
    type: String

  username:
    type: String
    required: true
    index:
      unique: true

  gender:
    type: String

  timezone:
    type: Number

  locale:
    type: String

  verified:
    type: Boolean

  location:
    type: String

  created:
    type: Date
    default: Date.now

  lastModified:
    type: Date
    default: Date.now

  # custom fields here
  points:
    type: Number
    default: 0
    min: 0

User.set 'toJSON', {getters:true,virtuals:true}
User.set 'toObject', {getters:true,virtuals:true}
User.set 'strict', true

User.pre 'save', (next) ->
  @lastModified = Date.now()
  next()

module.exports = User