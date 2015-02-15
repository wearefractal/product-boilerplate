{router} = require 'fission'
Index = require './views/Index'
Settings = require './views/Settings'
Setup = require './views/Setup'
Application = require './views/Application'

module.exports = router
  app:
    path: '/'
    view: Application
    defaultChild:
      view: Index
    children:
      settings:
        view: Settings
        path: 'settings'
      setup:
        view: Setup
        path: 'setup'
