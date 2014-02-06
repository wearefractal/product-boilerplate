define (require) ->
  User = model 'User'

  # schema
  User.attr '_id', 
    type: 'string'
    required: true

  User.attr 'fbid', 
    type: 'string'
    required: true

  User.attr 'name', 
    type: 'string'
    required: true

  User.attr 'username', 
    type: 'string'
    required: true

  User.attr 'location', 
    type: 'string'

  User.attr 'created',
    type: 'date'

  User.attr 'lastModified',
    type: 'date'

  User.attr 'points',
    type: 'number'

  # sync config
  User.route '/v1/users'

  return User