namespace 'None', (exports) ->
  exports.easeNone = (elapsed,change,duration,from) ->
    elapsed*(change/duration) + from
