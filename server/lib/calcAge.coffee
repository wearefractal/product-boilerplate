module.exports = (birthday) ->
  return~~ ((Date.now() - birthday) / 31557600000)
