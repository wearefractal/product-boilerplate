module.exports = (user) ->
  return '' unless user?
  serialized = JSON.stringify user, null, 2
  src += "window._user = #{serialized};"
  return src
