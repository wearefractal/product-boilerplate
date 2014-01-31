define (require) ->
  router = require 'app/router'
  router.start
    click: true
    dispatch: true
    popstate: true