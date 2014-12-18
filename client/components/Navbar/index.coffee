fission = require '../../app'
DOM = fission.DOM

Nav = fission.view
  render: ->
    # TODO: flesh this out
    return DOM.nav
      className: 'navbar-component'
    , @props.children

module.exports = Nav