request = require 'supertest'
app = require '../../start'
config = require '../../config'
db = require '../../db'
setup = require '../setup'

should = require 'should'
require 'mocha'

describe 'User PATCH', ->
  beforeEach setup.db.wipe
  beforeEach setup.user.create
  beforeEach setup.passport.hook
  afterEach setup.passport.unhook

  it 'should respond with 403 when not logged in', (done) ->
    request(app)
      .patch("#{config.apiPrefix}/users/123")
      .set('Accept', 'application/json')
      .expect(403, done)

  it 'should respond with 403 when logged in but not owner', (done) ->
    mod =
      points: 100

    request(app)
      .patch("#{config.apiPrefix}/users/#{setup.user.id}")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(setup.newId()))
      .send(mod)
      .expect(403, done)

  it 'should respond with 200 and information when logged in and points change', (done) ->
    mod =
      points: 100

    request(app)
      .patch("#{config.apiPrefix}/users/#{setup.user.id}")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(setup.user.id))
      .send(mod)
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        res.body.should.be.type 'object'
        res.body._id.should.equal setup.user.id
        res.body.points.should.equal 100
        done()