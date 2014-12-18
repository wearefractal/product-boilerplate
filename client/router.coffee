fission = require './app'
Router = require 'react-router'
Index = require './components/Index'
Application = require './components/Application'

indexPage = Router.DefaultRoute
  name: 'index'
  handler: Index

routes = Router.Route
  name: 'app'
  path: '/'
  handler: Application
, indexPage

Router.run routes, Router.HistoryLocation, (Handler, state) ->
  handler = Handler params: state.params
  fission.React.render handler, document.body