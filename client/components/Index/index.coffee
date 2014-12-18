fission = require '../../app'
DOM = fission.DOM

Index = fission.view
  render: ->
    return DOM.div
      className: 'index-component'
    , 'Test'

module.exports = Index