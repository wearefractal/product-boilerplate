setup = require '../setup'
app = require '../../start'
config = require '../../config'
db = require '../../db'
dbUtils = require 'mongoose-test-utils'

User = db.model 'User'
Comment = db.model 'Comment'

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

fakeComment =
  to: setup.newId()
  text: "wow"
  rating: 3.5

describe 'Comment POST plural', ->
  beforeEach dbUtils.wipe.bind null, db
  beforeEach (cb) ->
    User.create mock, cb

  it 'should respond with 403 when not logged in', (done) ->
    request(app)
      .post("#{config.apiPrefix}/comments")
      .set('Accept', 'application/json')
      .expect(403, done)

  it 'should respond with 200 and comment created', (done) ->
    request(app)
      .post("#{config.apiPrefix}/comments")
      .set('Accept', 'application/json')
      .query(setup.user.createQuery(mock._id))
      .send(fakeComment)
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        should.exist res.body._id
        res.body.to.should.equal fakeComment.to
        res.body.from.should.equal mock._id
        res.body.text.should.equal fakeComment.text
        res.body.rating.should.equal fakeComment.rating
        done()