define (require) ->
  return (ctx, next) ->
    console.log 'Routing called', ctx
    next()