{DOM, view} = require 'fission'

module.exports = view
  displayName: 'Setup'
  render: ->
    return DOM.div
      className: 'setup-component'
    , 'Setup view'
