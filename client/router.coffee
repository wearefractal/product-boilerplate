fission = require './fission'
Router = require 'react-router'

Index = require './components/Index'
Application = require './components/Application'

# util code
Route = fission.createFactory Router.Route
DefaultRoute = fission.createFactory Router.DefaultRoute
transformRoutes = (routes) ->
  # TODO: if only one key and no path then default = true
  totalKeys = Object.keys routes
  singleChild = (totalKeys.length is 1)

  for name, opt of routes
    if typeof opt is 'function'
      opt =
        handler: opt

    isDefault = (singleChild and !opt.path?) or !!opt.default
    ctor = (if isDefault then DefaultRoute else Route)
    childRoutes = (if opt.children? then transformRoutes(opt.children) else null)
    route = ctor
      key: name
      name: name
      path: opt.path
      handler: opt.handler
    , childRoutes

startRouter = (routes, container) ->
  Router.run transformRoutes(routes), Router.HistoryLocation, (Handler, state) ->
    handler = Handler state.params
    fission.React.render handler, container

# start actual app code
routes =
  app:
    path: '/'
    handler: Application
    children:
      index: Index

startRouter routes, document.body