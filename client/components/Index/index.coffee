fission = require '../../fission'
DOM = fission.DOM

Index = fission.view
  displayName: 'Index'
  render: ->
    return DOM.div
      className: 'index-component'
    , 'Test'

module.exports = Index