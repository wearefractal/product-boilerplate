{DOM, view} = require 'fission'
CircleIcon = require '../../components/CircleIcon'

Header = view
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
        background: "#333 url('/img/bg.png')"
        backgroundSize: 'cover'
        backgroundPosition: 'center'
    , statementContainer, downArrow

Info = view
  render: ->
    infoTitle = DOM.p
      className: 'title'
    , 'How it works'

    fbInfo = DOM.div
      className: 'info'
    ,

      CircleIcon
        text: 1
        background: '#2980b9'

      DOM.p
        className: 'info-header'
      , 'Sign up with Facebook'
      DOM.p null, 'content here'
    phoneInfo = DOM.div
      className: 'info'
    ,

      CircleIcon
        text: 2
        background: '#2980b9'

      DOM.p
        className: 'info-header'
      , 'Enter your phone number'
      DOM.p null, 'content here'


    return DOM.div
      id: 'info'
      className: 'info-component'
    , infoTitle,
      fbInfo, phoneInfo#, dinnerInfo, transportationInfo

module.exports = view
  displayName: 'Splash'
  render: ->
    return DOM.div
      className: 'splash-component'
    , Header(), Info()
