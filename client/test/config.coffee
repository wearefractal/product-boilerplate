should = require 'should'
config = require '../config'

describe 'config', ->
  it 'should have a title', (done) ->
    should.exist config.title
    done()