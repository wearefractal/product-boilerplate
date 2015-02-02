{DOM, view} = require 'fission'

module.exports = view
  displayName: 'Navbar'
  render: ->
    # TODO: flesh this out
    return DOM.nav
      className: 'navbar-component'
    , @props.children