request = require 'supertest'
app = require '../../server/start'
config = require '../../server/config'
setup = require '../setup'

should = require 'should'
require 'mocha'

describe 'User GET', ->
  beforeEach setup.db.wipe
  beforeEach setup.user.create
  beforeEach setup.passport.hook
  afterEach setup.passport.unhook

  it 'should respond with 403 when not logged in', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users/123")
      .set('Accept', 'application/json')
      .expect(403, done)

  it 'should respond with 200 and information when logged in', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users/#{setup.user.id}")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(setup.user.id))
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        res.body.should.be.type 'object'
        res.body._id.should.equal setup.user.id
        should.exist res.body.token, 'should show user token'
        done()