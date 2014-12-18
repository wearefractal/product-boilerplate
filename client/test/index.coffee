should = require 'should'
app = require '../'

describe 'index', ->
  it 'should add a window.React', (done) ->
    should.exist window.React
    done()