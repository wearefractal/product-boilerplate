{DOM, view} = require 'fission'

module.exports = view
  displayName: 'Index'
  render: ->
    return DOM.div
      className: 'index-component'
    , 'Test'
