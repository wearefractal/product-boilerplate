{DOM, view} = require 'fission'
css = require './index.styl'

module.exports = view
  displayName: 'Setup'
  css: css
  render: ->
    return DOM.div
      className: 'setup-component'
    , 'Setup view'
