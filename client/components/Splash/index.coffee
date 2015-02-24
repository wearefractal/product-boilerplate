{DOM, view, PropTypes, component} = require 'fission'
CircleIcon = require '../CircleIcon'

Header = component
  propTypes:
    header: PropTypes.string.isRequired
    subheader: PropTypes.string
    background: PropTypes.string.isRequired
    loginText: PropTypes.string.isRequired

  getDefaultProps: ->
    background: '/img/bg.png'
    loginText: 'Login'

  login: ->
    window.location = '/auth/facebook'

  render: ->
    loginButton = DOM.button
      className: 'pure-button pure-button-primary login-button'
      onClick: @login
    , @props.loginText

    subheader = DOM.div
      className: 'statement-subtext'
    , @props.subheader

    downArrow = DOM.a
      className: 'down-arrow'
      href: '#info'
    , DOM.img src: '/img/down.svg'

    statement = DOM.div
      className: 'statement-text'
    , @props.header, subheader

    statementContainer = DOM.div
      className: 'statement-container'
    , statement, loginButton

    return DOM.div
      className: 'header-component'
      style:
        backgroundColor: '#333'
        backgroundImage: "url(#{@props.background})"
        backgroundSize: 'cover'
        backgroundPosition: 'center'
    , statementContainer, downArrow


InfoItem = component
  propTypes:
    number: PropTypes.number.isRequired
    header: PropTypes.string.isRequired
    content: PropTypes.string.isRequired

  render: ->
    num = (n) ->
      return CircleIcon
        text: n
        background: '#2980b9'

    content = DOM.p null, @props.content
    header = DOM.p
      className: 'info-header'
    , @props.header

    return DOM.div
      className: 'info'
    , num(@props.number), header, content


Info = component
  propTypes:
    items: PropTypes.arrayOf PropTypes.shape
      header: PropTypes.string.isRequired
      content: PropTypes.string.isRequired

  render: ->
    infoTitle = DOM.p
      className: 'title'
    , 'How it works'

    infoItems = @props.items.map (v, k) ->
      v.number = ++k
      v.key = "#{k}-info"
      return InfoItem v

    return DOM.div
      id: 'info'
      className: 'info-component'
    , infoTitle, infoItems



module.exports = component
  displayName: 'SplashComponent'
  propsTypes:
    header: PropTypes.string.isRequired
    subheader: PropTypes.string
    background: PropTypes.string.isRequired
    info: PropTypes.arrayOf PropTypes.shape
      header: PropTypes.string.isRequired
      content: PropTypes.string.isRequired

  render: ->
    header = Header
      header: @props.header
      subheader: @props.subheader
      background: @props.background
      loginText: @props.loginText

    info = Info items: @props.info

    return DOM.div
      className: 'splash-component'
    , header, info
