fission = require 'fission'
DOM = fission.DOM

Index = fission.view
  render: ->
    return DOM.div null, 'Test'

module.exports = Index