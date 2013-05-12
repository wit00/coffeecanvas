#The CollisionResponse Namespace is a set of functions designed
#to work well as the toDo functions for collision events
namespace 'CollisionResponse', (exports) ->
  #move back a little before the collision 
  exports.moveBeforeCollision = (o) ->
    o.rotation = o.rotation - ((o.rotation-o.delta.rotation)*3)
    o.x = o.x - ((o.x-o.delta.x)*3) 
    o.y = o.y - ((o.y-o.delta.y)*3) 
    o.adjustedX = o.adjustedX - ((o.adjustedX-o.delta.x)*3)
    o.adjustedY = o.adjustedY - ((o.adjustedY-o.delta.y)*3)
  #stop all movement
  exports.stop = (o)->
    CollisionResponse.moveBeforeCollision(o)
    o.xVelocity = 0
    o.yVelocity = 0
  #a reasonable way to bounce off of walls
  exports.randomBounce = (o)->
    direction = true
    randomnumber=(Math.floor(Math.random()*11))
    rand2 = Math.floor(Math.random()*11)
    if rand2 > 4
      direction = false
      randomnumber = randomnumber*(-1)
    randomnumber = randomnumber/71
    #CollisionResponse.moveBeforeCollision(o)
    o.xVelocity = o.xVelocity*-1 
    if o.y >= 200
      o.yVelocity = -.1
    if o.y < 200
      o.yVelocity = 0.1
  
