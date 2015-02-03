{DOM, ChildView, view} = require 'fission'
Navbar = require '../Navbar'

module.exports = view
  displayName: 'Application'
  render: ->
    return DOM.div
      className: 'application-component'
    , Navbar(), ChildView()
