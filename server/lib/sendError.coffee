log = require './log'

module.exports = (res, err, code=500) ->
  res.status code
  log.info err
  if typeof err is 'string'
    res.json
      error:
        message: err
  else if err?.message?
    res.json
      error:
        message: err.message
  else
    res.json error: err

  return res