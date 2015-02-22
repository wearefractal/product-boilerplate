{DOM, view, Link} = require 'fission'

module.exports = view
  displayName: 'Navbar'
  getDefaultProps: ->
    links: []

  render: ->
    list = DOM.div
      className: 'links',
    , @props.links.map (link) ->
      link.key = "#{link.to}-nav-link"
      return Link link, link.label

    return DOM.nav
      className: 'navbar-component'
    , list
