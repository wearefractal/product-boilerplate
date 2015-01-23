fission = require '../../fission'
DOM = fission.DOM

Nav = fission.view
  displayName: 'Navbar'
  render: ->
    # TODO: flesh this out
    return DOM.nav
      className: 'navbar-component'
    , @props.children

module.exports = Nav