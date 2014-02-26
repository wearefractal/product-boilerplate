define (require) ->
  Comment = model 'Comment'

  # schema
  Comment.attr '_id', 
    type: 'string'
    required: true

  Comment.attr 'to',
    type: 'string'

  Comment.attr 'from',
    type: 'object'

  Comment.attr 'created',
    type: 'date'

  Comment.attr 'rating',
    type: 'number'

  # sync config
  Comment.route '/v1/comments'

  Comment.getByTo = (id, cb) ->
    url = @url ''
    @request
      .get(url)
      .query(to: id)
      .set(@_headers)
      .end (err, res) =>
        return cb err if err?
        col = new Collection
        for item in res.body
          col.push new @ item

        cb null, col, res

  Comment.getByFrom = (id, cb) ->
    url = @url ''
    @request
      .get(url)
      .query(from: id)
      .set(@_headers)
      .end (err, res) =>
        return cb err if err?
        col = new Collection
        for item in res.body
          col.push new @ item

        cb null, col, res

  return Comment