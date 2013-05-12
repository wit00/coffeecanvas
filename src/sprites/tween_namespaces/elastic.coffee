namespace 'Elastic', (exports) ->
  exports.easeIn = (elapsed,change,duration,from)->
    if elapsed is 0
      return from
    if ((elapsed/=duration) is 1)
      return from + change
    else
      period = duration * 0.3
      s = period/4
      return -(change*Math.pow(2,10*(elapsed-=1))*Math.sin((elapsed*duration-s)*(6.28)/period)) + from
  exports.easeOut = (elapsed,change,duration,from)->
    if elapsed is 0
      return from
    if ((elapsed/=duration) is 1)
      return from + change
    else
      period = duration*0.3
      s=period/4
      return change*Math.pow(2,-10*elapsed)*Math.sin((elapsed*duration-s)*(6.28)/period)+change+from
  exports.easeInOut = (elapsed,change,duration,from)->
    if elapsed is 0
      return from
    if ((elapsed/=duration/2) is 2)
      return from + change
    else
      period = duration*(0.3*1.5)
      s = period/4
      if elapsed < 1
        return 0.5*(change*Math.pow(2,10*(elapsed-=1))*Math.sin((elapsed*duration-s)*(6.28)/period))+ from
      else
        return change*Math.pow(2,-10*(elapsed-=1))*Math.sin((elapsed*duration-s)*(6.28)/period)*-.5 + change + from      
      
