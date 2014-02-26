setup = require '../setup'
app = require '../../start'
config = require '../../config'
db = require '../../db'

Comment = db.model 'Comment'
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

mock2 =
  _id: setup.newId()
  fbid: 12345678
  name: "Mike Adams Clone"
  first_name: "Mike"
  last_name: "AdamsClone"
  token: "sofake2"
  username: "mikeadams2"

fakeComment =
  _id: setup.newId()
  from: mock._id
  to: setup.newId()
  text: "wow"
  rating: 3.5

fakeComment2 =
  _id: setup.newId()
  from: mock2._id
  to: mock._id
  text: "wow"
  rating: 3.5

describe 'Comment GET plural', ->
  beforeEach db.wipe
  beforeEach (cb) ->
    User.create [mock, mock2], cb
  beforeEach (cb) ->
    Comment.create [fakeComment, fakeComment2], cb

  it 'should respond with 400 when no from or two present', (done) ->
    request(app)
      .get("#{config.apiPrefix}/comments")
      .set('Accept', 'application/json')
      .expect(400, done)

  it 'should respond with 200 and comments by from', (done) ->
    request(app)
      .get("#{config.apiPrefix}/comments")
      .set('Accept', 'application/json')
      .query(
        from: fakeComment.from
      )
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        Array.isArray(res.body).should.equal true
        res.body.length.should.equal 1
        res.body[0]._id.should.equal fakeComment._id
        res.body[0].to.should.equal fakeComment.to
        res.body[0].from._id.should.equal fakeComment.from
        res.body[0].text.should.equal fakeComment.text
        res.body[0].rating.should.equal fakeComment.rating
        done()

  it 'should respond with 200 and comments by to', (done) ->
    request(app)
      .get("#{config.apiPrefix}/comments")
      .set('Accept', 'application/json')
      .query(
        to: fakeComment2.to
      )
      .expect('Content-Type', /json/)
      .expect(200)
      .end (err, res) ->
        return done err if err?
        should.exist res.body
        Array.isArray(res.body).should.equal true
        res.body.length.should.equal 1
        res.body[0]._id.should.equal fakeComment2._id
        res.body[0].to.should.equal fakeComment2.to
        res.body[0].from._id.should.equal fakeComment2.from
        res.body[0].text.should.equal fakeComment2.text
        res.body[0].rating.should.equal fakeComment2.rating
        done()