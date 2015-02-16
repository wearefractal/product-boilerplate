{component, DOM, PropTypes} = require 'fission'

module.exports = component
  displayName: 'CircleIcon'
  propTypes:
    text: PropTypes.oneOfType([
      PropTypes.string
      PropTypes.number
    ]).isRequired
    background: PropTypes.string

  getDefaultProps: ->
    o =
      background: '#7f8c8d'

  render: ->
    IconNumber = DOM.span
      className: 'text'
    , @props.text

    return DOM.div
      className: 'circleicon-component'
      style:
        background: @props.background
    , IconNumber
