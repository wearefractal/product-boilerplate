{Schema} = require 'mongoose'
format_fields = require 'mongoose-format-fields'

Model = new Schema
  # fb fields
  fbid:
    grants: ['admin']
    type: String
    required: true
    index:
      unique: true

  name:
    grants: ['admin']
    type: String
    required: true

  first_name:
    grants: 'public'
    type: String
    required: true

  last_name:
    grants: ['admin']
    type: String
    required: true

  token:
    grants: ['admin']
    type: String
    required: true

  gender:
    grants: 'public'
    type: String
    lowercase: true

  timezone:
    grants: ['admin']
    type: Number

  locale:
    grants: ['admin']
    type: String

  verified:
    grants: ['admin']
    type: Boolean

  location:
    grants: 'public'
    type: String
    default: 'Earth'

  bio:
    grants: 'public'
    type: String

  created:
    grants: ['admin']
    type: Date
    default: Date.now

  lastModified:
    grants: ['admin']
    type: Date
    default: Date.now

  # custom fields here
  ready:
    grants: ['admin']
    type: Boolean
    default: false

  nextReservation:
    grants: ['admin']
    type: Schema.Types.ObjectId
    ref: 'Reservation'

  phone:
    grants: 'public'
    type: String
    validate: /^\d{10}$/
    unique: true

Model.virtual('image').get ->
  return "http://graph.facebook.com/#{@fbid}/picture?height=800&type=normal&width=800"

Model.set 'id_grants', 'public'
Model.set 'id_output', 'id'

Model.set 'toJSON', {getters:true, virtuals:true}
Model.set 'toObject', {getters:true, virtuals:true}
Model.set 'strict', true

Model.pre 'save', (next) ->
  @lastModified = Date.now()
  next()

Model.plugin format_fields

module.exports = Model
