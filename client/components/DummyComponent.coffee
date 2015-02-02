{component, DOM} = require 'fission'

module.exports = component
  render: ->
    return DOM.p null, 'Dummy'