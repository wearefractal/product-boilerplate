{router} = require 'fission'
Index = require './views/Index'
Settings = require './views/Settings'
Setup = require './views/Setup'
Splash = require './views/Splash'
Application = require './views/Application'

module.exports = router
  app:
    path: '/'
    view: Application
    defaultChild:
      view: Index
    children:
      home:
        view: Index
        path: 'home'
      settings:
        view: Settings
        path: 'settings'
      setup:
        view: Setup
        path: 'setup'
      splash:
        view: Splash
        path: 'splash'
