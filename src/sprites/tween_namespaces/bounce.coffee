namespace 'Bounce', (exports) ->
  exports.easeIn = (elapsed,change,duration,from)->
    change-Bounce.easeOut(duration-elapsed,change,duration,0) + from
  exports.easeOut = (elapsed,change,duration,from) ->
    if((elapsed/=duration) < (1/2.75))
      return change*(7.5625*elapsed*elapsed) + from
    if(elapsed < (2/2.75))
      return change*(7.5625*(elapsed-=(1.5/2.75))*elapsed+0.75) + from
    if(elapsed < (2.5/2.75))
      return change*(7.5625*(elapsed-=(2.25/2.75))*elapsed + 0.9375) + from
    else
      return change*(7.5625*(elapsed-=(2.625/2.75))*elapsed+0.984375) + from
  exports.easeInOut = (elapsed,change,duration,from)->
    if(elapsed < duration/2)
      return Bounce.easeIn(elapsed*2,change,duration,0)*0.5+from
    else
      return Bounce.easeOut(elapsed*2-duration,change,duration,0)*0.5+change*0.5+from
