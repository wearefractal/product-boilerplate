should = require 'should'
config = require '../config'

describe 'config', ->
  it 'should exist', (done) ->
    should.exist config
    done()
