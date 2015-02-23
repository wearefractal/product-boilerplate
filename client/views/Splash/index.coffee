{DOM, view, PropTypes} = require 'fission'
Splash = require '../../components/Splash'

module.exports = view
  displayName: 'Splash'
  render: ->
    return DOM.div null,
      Splash
        header: 'Splash'
        subheader: 'subheader'
        background: '/img/bg.jpg'
        info: [header: 'Header', content: 'Content here']
