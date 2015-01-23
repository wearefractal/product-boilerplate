fission = require '../../fission'
DOM = fission.DOM

Settings = fission.view
  displayName: 'Settings'
  render: ->
    return DOM.div
      className: 'settings-component'
    , 'Settings'

module.exports = Settings