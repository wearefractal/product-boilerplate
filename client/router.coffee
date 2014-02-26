define (require) ->
  app = require 'app/sugar'

  app.use 'middleware/log'
  app.use
    view: 'pages/Navbar/View'
    el: 'navbar'

  app.route '/',
    title: "APPNAME"
    view: 'pages/Index/View'
    el: 'content'
    continue: false

  app.route '/people',
    title: "APPNAME - People"
    view: 'pages/People/View'
    el: 'content'
    continue: false

  app.route '/people/:id',
    title: "APPNAME - Person"
    view: 'pages/Person/View'
    el: 'content'
    continue: false

  app.use
    title: "APPNAME - Not found"
    view: 'pages/NotFound/View'
    el: 'content'
    continue: false

  return app