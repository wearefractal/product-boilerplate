{DOM, view} = require 'fission'
css = require './index.styl'

module.exports = view
  displayName: 'Index'
  css: css
  render: ->
    return DOM.div
      className: 'index-component'
    , 'Index view'
