fission = require '../../app'
{RouteHandler} = require 'react-router'
DOM = fission.DOM

Application = fission.view
  render: ->
    return RouteHandler()

module.exports = Application