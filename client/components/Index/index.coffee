fission = require '../../app'
DOM = fission.DOM

Index = fission.view
  render: ->
    return DOM.div
      className: 'index'
    , 'Test'

module.exports = Index