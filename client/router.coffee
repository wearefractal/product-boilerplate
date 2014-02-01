define (require) ->
  app = require 'app/sugar'

  app.route '*', 'middleware/log'
  app.route '*',
    view: 'pages/Navbar/View'
    el: 'navbar'

  app.route '/',
    title: "APPNAME"
    view: 'pages/Index/View'
    el: 'content'
    continue: false

  app.route '*',
    title: "APPNAME - Not found"
    view: 'pages/NotFound/View'
    el: 'content'
    continue: false

  return app