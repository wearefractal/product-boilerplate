fission = require '../../fission'
Router = require 'react-router'
DOM = fission.DOM

Nav = fission.view
  displayName: 'Navbar'
  mixins: [Router.State]
  render: ->
    # TODO: flesh this out
    return DOM.nav
      className: 'navbar-component'
    , @props.children

module.exports = Nav