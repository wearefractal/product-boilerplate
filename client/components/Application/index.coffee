fission = require '../../app'
{RouteHandler} = require 'react-router'
DOM = fission.DOM
Navbar = fission.createFactory require '../Navbar'

Application = fission.view
  render: ->
    return DOM.div
      className: 'application-component'
    , Navbar(), RouteHandler()

module.exports = Application