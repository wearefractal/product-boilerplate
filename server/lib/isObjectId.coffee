checkForHexRegExp = /^[0-9a-fA-F]{24}$/

module.exports = (v) ->
  return false unless typeof v is 'string'
  return checkForHexRegExp.test v