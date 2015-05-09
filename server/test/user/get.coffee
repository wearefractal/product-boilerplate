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

describe 'User GET', ->
  beforeEach dbUtils.wipe.bind null, db
  beforeEach (cb) ->
    User.create mock, cb

  it 'should respond with 200 and information when logged in', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users/#{mock._id}")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(mock._id))
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        res.body.should.be.type 'object'
        res.body._id.should.equal mock._id
        should.exist res.body.token, 'should show user token'
        done()

  it 'should respond with 200 and information when not logged in', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users/#{mock._id}")
      .set('Accept', 'application/json')
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        res.body.should.be.type 'object'
        res.body._id.should.equal mock._id
        should.not.exist res.body.token, 'should not show user token'
        done()

  it 'should respond with 200 and information when logged in with username query', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users/#{mock.username}")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(mock._id))
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        res.body.should.be.type 'object'
        res.body._id.should.equal mock._id
        should.exist res.body.token, 'should show user token'
        done()

  it 'should respond with 200 and information when not logged in with username query', (done) ->
    request(app)
      .get("#{config.apiPrefix}/users/#{mock.username}")
      .set('Accept', 'application/json')
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        res.body.should.be.type 'object'
        res.body._id.should.equal mock._id
        should.not.exist res.body.token, 'should not show user token'
        done()
