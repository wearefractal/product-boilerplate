fission = require '../../fission'
Router = require 'react-router'

Navbar = fission.createFactory require '../Navbar'
RouteHandler = fission.createFactory Router.RouteHandler
DOM = fission.DOM

Application = fission.view
  displayName: 'Application'
  render: ->
    return DOM.div
      className: 'application-component'
    , Navbar(), RouteHandler()

module.exports = Application