request = require 'supertest'
app = require '../../server/start'
config = require '../../server/config'
db = require '../../server/database'
setup = require '../setup'

Roster = db.model 'Roster'

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
    mod = new Roster
      QB: [setup.newId()]

    request(app)
      .patch("#{config.apiPrefix}/users/#{setup.user.id}")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(setup.newId()))
      .send(mod)
      .expect(403, done)

  it 'should respond with 200 and information when logged in and roster change', (done) ->
    mod = new Roster
      QB: [setup.newId()]

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
        res.body.roster.QB.length.should.equal mod.QB.length
        res.body.roster.QB[0].should.equal String mod.QB[0]
        done()