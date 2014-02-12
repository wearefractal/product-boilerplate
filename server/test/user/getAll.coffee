request = require 'supertest'
app = require '../../start'
config = require '../../config'
setup = require '../setup'

should = require 'should'
require 'mocha'

describe 'User GET plural', ->
  beforeEach setup.db.wipe
  beforeEach setup.user.create
  beforeEach setup.passport.hook
  afterEach setup.passport.unhook

  it 'should respond with 200 when not logged in', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users")
      .set('Accept', 'application/json')
      .expect(200, done)

  it 'should respond with 200 and information when logged in', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(setup.user.id))
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        Array.isArray(res.body).should.equal true
        res.body.length.should.equal 1
        res.body[0]._id.should.equal setup.user.id
        should.not.exist res.body[0].token, 'should not show user token'
        done()