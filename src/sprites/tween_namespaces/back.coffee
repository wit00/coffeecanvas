namespace 'Back', (exports) ->
  exports.easeIn = (elapsed,change,duration,from)->
    change*(elapsed/=duration)*elapsed*((1.70158+1)*elapsed-1.70158) + from
  exports.easeOut = (elapsed,change,duration,from) ->
    change*((elapsed=elapsed/duration-1)*elapsed*(( 1.70158+1)*elapsed+ 1.70158)+1)+from
  exports.easeInOut = (elapsed,change,duration,from)->
    s =  1.70158
    if((elapsed/=duration/2) < 1)
      return (change/2)*(elapsed*elapsed*(((s*=(1.525))+1)*elapsed-s)) + from
    else
     return (change/2)*((elapsed-=2)*elapsed*(((s*=(1.525))+1)*elapsed + s)+2)+from
      
