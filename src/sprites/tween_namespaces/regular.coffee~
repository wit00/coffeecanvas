namespace 'Regular', (exports) ->
  exports.easeIn = (elapsed,change,duration,from)->
    change*(elapsed/=duration)*elapsed + from
  exports.easeOut = (elapsed,change,duration,from) ->
    -change*(elapsed/=duration)*(elapsed-2) + from
  exports.easeInOut = (elapsed,change,duration,from)->
    if((elapsed/=duration/2) < 1)
      return (change/2)*elapsed*elapsed + from 
    else
      return (-change/2)*((--elapsed)*(elapsed-2)-1) + from
      
      
