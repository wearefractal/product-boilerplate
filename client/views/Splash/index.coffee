{DOM, view, PropTypes, createFactory} = require 'fission'
Splash = createFactory require 'components/components/Splash'
css = require './index.styl'

module.exports = view
  displayName: 'Splash'
  css: css
  render: ->
    return Splash
      header: 'Splash'
      subheader: 'subheader'
      background: '/img/bg.jpg'
      info: [header: 'Header', content: 'Content here']
      loginUrl: '/auth/facebook'
      loginText: [
        DOM.i className: 'fa fa-facebook-official'
        'Log in with Facebook'
      ]
