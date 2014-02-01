module.exports = (user) ->
  src = "define(function(){\n"
  if user?
    serialized = JSON.stringify user, null, 2
    src += "  var out = #{serialized};\n"
    src += "  return out;\n"
  else
    src += "  return;\n"
  src += "});"

  return src