fission = require './fission'

Index = require './components/Index'
Index = require './components/Settings'
Application = require './components/Application'

module.exports = fission.router
  app:
    path: '/'
    handler: Application
    children:
      settings:
        handler: Settings
        path: 'settings'
      index:
        handler: Index
        default: true