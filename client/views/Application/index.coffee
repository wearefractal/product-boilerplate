{DOM, ChildView, view, createFactory} = require 'fission'
Navbar = createFactory require 'components/components/Navbar'
me = require '../../me'
css = require './index.styl'

links = [
  label: 'Home'
  to: 'home'
,
  label: 'Settings'
  to: 'settings'
]

module.exports = view
  displayName: 'Application'
  css: css
  render: ->
    return DOM.div
      className: 'application-component'
    , Navbar(links: links), ChildView()
