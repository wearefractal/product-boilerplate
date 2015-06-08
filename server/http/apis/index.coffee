app = require '../express'
log = require '../../lib/log'
pluralize = require 'pluralize'
path = require 'path'
requireDir = require 'require-dir'
pkg = require '../../../package'
config = require '../../config'

resDir = path.join __dirname, '../../resources'
resources = requireDir resDir, recurse: true

methods =
  find:
    method: 'get'
    plural: true
  create:
    method: 'post'
    plural: true
  findById:
    method: 'get'
    plural: false
  replaceById:
    method: 'put'
    plural: false
  modifyById:
    method: 'patch'
    plural: false
  deleteById:
    method: 'delete'
    plural: false

wrap = (fn) ->
  return (req, res, next) ->
    opt =
      id: req.params.id
      data: req.body
      options: req.query
      _req: req
      _res: res

    fn req.user, opt, (err, data) ->
      if err?
        res.status err.status or 500
        res.json error: err.message or err.error?.message or err.error
      else if data?
        res.status data.status or 200
        res.json data.result

registerRoute = (method, route, fns...) ->
  log.info "#{method.toUpperCase()} #{route} registered"
  app[method] route, fns...
  return app

infoEndpoint = (req, res, next) ->
  res.status 200
  res.json
    name: pkg.name
    version: pkg.version

registerRoute 'get', config.api.prefix, infoEndpoint

# Actual APIs
for resource, handlers of resources
  for serviceType, fn of handlers when typeof fn is 'function'
    pluralized = pluralize.plural resource
    method = methods[serviceType] or fn.http

    # convention-based service
    if method?
      path = "#{config.api.prefix}/#{pluralized}"
      path += "/:id" unless method.plural is true # non-plural fns
      path += "/#{serviceType}" unless methods[serviceType]? # custom fns
      registerRoute method.method, path, wrap fn
    else
      throw new Error 'You need to export an HTTP config or use a default service name'

module.exports = app