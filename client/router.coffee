{router} = require 'fission'
Index = require './views/Index'
Settings = require './views/Settings'
Application = require './views/Application'

module.exports = router
  app:
    path: '/'
    view: Application
    children:
      settings:
        view: Settings
        path: 'settings'
      index:
        view: Index
        default: true