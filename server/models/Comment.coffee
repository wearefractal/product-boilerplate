{Schema} = require 'mongoose'
formatFields = require 'mongoose-format-fields'

Model = new Schema
  text:
    type: String
    default: ''
    validate: (v) -> v.length <= 140
    grants: ['public']

  from:
    type: Schema.Types.ObjectId
    ref: 'User'
    required: true
    grants: ['public']

  to:
    type: Schema.Types.ObjectId
    ref: 'User'
    required: true
    grants: ['public']

  created:
    type: Date
    default: Date.now
    grants: ['public']

  lastModified:
    grants: ['admin']
    type: Date
    default: Date.now

  # custom fields here
  rating:
    type: Number
    default: 3
    max: 5
    min: 1
    grants: ['public']

Model.set 'id_grants', 'public'
Model.set 'id_output', 'id'

Model.set 'toJSON', {getters:true, virtuals:true}
Model.set 'toObject', {getters:true, virtuals:true}
Model.set 'strict', true

Model.plugin formatFields

module.exports = Model
