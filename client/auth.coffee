define (require) ->
  auth = {}

  auth.loggedIn = -> false
  return auth