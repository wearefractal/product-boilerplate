{component, DOM, PropTypes} = require 'fission'

css = require './index.styl'

module.exports = component
  displayName: 'CircleIcon'
  css: css
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
