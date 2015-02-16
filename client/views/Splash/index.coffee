{DOM, view} = require 'fission'
CircleIcon = require '../../components/CircleIcon'

Header = view
  getDefaultProps: ->
    backgroundImage: '/img/bg.png'

  login: ->
    window.location = '/auth/facebook'

  render: ->
    loginButton = DOM.button
      className: 'pure-button pure-button-primary login-button'
      onClick: @login
    , 'Login with Facebook'

    subheader = DOM.div
      className: 'statement-subtext'
    ,'Subheading'

    downArrow = DOM.a
      className: 'down-arrow'
      href: '#info'
    , DOM.img src: '/img/down.svg'

    statement = DOM.div
      className: 'statement-text'
    , 'Statement', subheader

    statementContainer = DOM.div
      className: 'statement-container'
    , statement, loginButton

    return DOM.div
      className: 'header-component'
      style:
        backgroundColor: '#333'
        backgroundImage: "url(#{@props.backgroundImage})"
        backgroundSize: 'cover'
        backgroundPosition: 'center'
    , statementContainer, downArrow

Info = view
  render: ->
    num = (n) ->
      CircleIcon
        text: n
        background: '#2980b9'

    infoTitle = DOM.p
      className: 'title'
    , 'How it works'

    fbInfoContent = DOM.p null, 'content here'
    fbInfoHeader = DOM.p
      className: 'info-header'
    , 'Sign in with Facebook'
    fbInfo = DOM.div
      className: 'info'
    , num(1), fbInfoHeader, fbInfoContent

    phoneInfoContent = DOM.p null, 'content here'
    phoneInfoHeader = DOM.p
      className: 'info-header'
    , 'Enter your phone number'
    phoneInfo = DOM.div
      className: 'info'
    , num(2), phoneInfoHeader, phoneInfoContent


    return DOM.div
      id: 'info'
      className: 'info-component'
    , infoTitle, fbInfo, phoneInfo

module.exports = view
  displayName: 'Splash'
  render: ->
    return DOM.div
      className: 'splash-component'
    , Header(), Info()
