module.exports = (user) ->
  src = "define(['models/User'], function(User){\n"
  if user?
    serialized = JSON.stringify user, null, 2
    src += "  var out = new User(#{serialized});\n"
    src += "  return out;\n"
  else
    src += "  return;\n"
  src += "});"

  return src