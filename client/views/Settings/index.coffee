{DOM, view} = require 'fission'
css = require './index.styl'

module.exports = view
  displayName: 'Settings'
  css: css
  render: ->
    return DOM.div
      className: 'settings-component'
    , 'Settings view'
