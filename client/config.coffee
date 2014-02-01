packages = []

packages.push
  name: 'app'
  location: '.'

packages.push
  name: 'components'
  location: '/components'

packages.push
  name: 'pages'
  location: '/pages'

packages.push
  name: 'models'
  location: '/models'

packages.push
  name: 'middleware'
  location: '/middleware'

packages.push
  name: 'vendor'
  location: '/vendor'

require
  baseUrl: '.'
  packages: packages
, ['app/main']