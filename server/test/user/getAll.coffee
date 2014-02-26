setup = require '../setup'
app = require '../../start'
config = require '../../config'
db = require '../../db'

User = db.model 'User'

request = require 'supertest'
should = require 'should'
require 'mocha'

mock =
  _id: setup.newId()
  fbid: 1234567
  name: "Mike Adams"
  first_name: "Mike"
  last_name: "Adams"
  token: "sofake"
  username: "mikeadams"

describe 'User GET plural', ->
  beforeEach db.wipe
  beforeEach (cb) ->
    User.create mock, cb

  it 'should respond with 200 when not logged in', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users")
      .set('Accept', 'application/json')
      .expect(200, done)

  it 'should respond with 200 and information when logged in', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(mock._id))
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        Array.isArray(res.body).should.equal true
        res.body.length.should.equal 1
        res.body[0]._id.should.equal mock._id
        should.not.exist res.body[0].token, 'should not show user token'
        done()