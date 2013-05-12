namespace 'Vector', (exports) ->
  exports.add = (vec1x,vec1y,vec2x,vec2y)->
    vec = 
      x:vec1x+vec2x
      y:vec1y+vec2y
    return vec  
  exports.subtract = (vec1x,vec1y,vec2x,vec2y)->
    vec = 
      x:vec1x-vec2x
      y:vec1y-vec2y
    return vec
  exports.dotProduct = (vec1x,vec1y,vec2x,vec2y) ->
    return (vec1x*vec2x) + (vec1y*vec2y)
  exports.length = (vecX,vecY) ->
    return Math.sqrt((vecX*vecX) + (vecY*vecY))
  exports.normalize = (vecX,vecY) ->
    length = Vector.length(vecX,vecY)
    vec = 
      x:vecX/length
      y:vecY/length
    return vec
  exports.scale = (scalar,vecX,vecY) ->
    vec = 
      x:scalar*vecX
      y:scalar*vecY
    return vec
      
