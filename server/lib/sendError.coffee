module.exports = (res, err, code=500) ->
  res.status code

  if typeof err is 'string'
    res.json
      error:
        message: err
  else
    res.json error: err

  return res