{DOM, view} = require 'fission'

module.exports = view
  displayName: 'Settings'
  render: ->
    return DOM.div
      className: 'settings-component'
    , 'Settings'
