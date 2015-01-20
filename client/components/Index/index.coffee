fission = require '../../fission'
Router = require 'react-router'
DOM = fission.DOM

Index = fission.view
  displayName: 'Index'
  mixins: [Router.State]
  render: ->
    return DOM.div
      className: 'index-component'
    , 'Test'

module.exports = Index