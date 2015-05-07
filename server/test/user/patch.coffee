setup = require '../setup'
app = require '../../start'
config = require '../../config'
db = require '../../db'
dbUtils = require 'mongoose-test-utils'

{User} = db.models

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

describe 'User PATCH', ->
  beforeEach dbUtils.wipe.bind null, db
  beforeEach (cb) ->
    User.create mock, cb

  it 'should respond with 403 when not logged in', (done) ->
    request(app)
      .patch("#{config.apiPrefix}/users/123")
      .set('Accept', 'application/json')
      .expect(403, done)

  it 'should respond with 403 when logged in but not owner', (done) ->
    mod =
      points: 100

    request(app)
      .patch("#{config.apiPrefix}/users/#{mock._id}")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(setup.newId()))
      .send(mod)
      .expect(403, done)

  it 'should respond with 200 and information when logged in and points change', (done) ->
    mod =
      points: 100

    request(app)
      .patch("#{config.apiPrefix}/users/#{mock._id}")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(mock._id))
      .send(mod)
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        res.body.should.be.type 'object'
        res.body._id.should.equal mock._id
        res.body.points.should.equal 100
        done()
