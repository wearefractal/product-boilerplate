{DOM, ChildView, view} = require 'fission'
Navbar = require '../Navbar'

links = [
  label: 'Home'
  to: 'home'
,
  label: 'Settings'
  to: 'settings'
]

module.exports = view
  displayName: 'Application'
  render: ->
    return DOM.div
      className: 'application-component'
    , Navbar(links: links), ChildView()
