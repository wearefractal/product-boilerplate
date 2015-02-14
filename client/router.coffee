{router} = require 'fission'
Index = require './views/Index'
Settings = require './views/Settings'
Setup = require './views/Setup'
Application = require './views/Application'

module.exports = router
  app:
    path: '/'
    view: Application
    children:
      settings:
        view: Settings
        path: 'settings'
      setup:
        view: Setup
        path: 'setup'
      index:
        view: Index
        default: true
