scene = new Scene
gameLoop = new GameLoop
collisions = new CollisionManager(scene)
obj1 = new Circle(x:100,y:100,radius:40,fill:"blue",xVelocity:0.1,yVelocity:0.1)
obj2 = new Circle(y:300,x:30,xVelocity:0.3,yVelocity:-0.3)
obj3 = new Circle(x:300,y:300,radius:10,fill:"green",xVelocity:-0.1,yVelocity:0.1)
obj4 = new Circle(x:40,y:30,xVelocity:-0.3,yVelocity:-0.3,fill:"red")
obj5 = new Circle(x:300,y:300,radius:10,fill:"orange",xVelocity:-0.2,yVelocity:0.1)
scene.addSprite(obj1)
scene.addSprite(obj2)
scene.addSprite(obj3)
scene.addSprite(obj4)
scene.addSprite(obj5)
obj1.addEvent(type:collisions,objectType:"boundary",toDo:f=->CollisionResponse.randomBounce(obj1))
obj2.addEvent(type:collisions,objectType:"boundary",toDo:f=->CollisionResponse.randomBounce(obj2))
obj3.addEvent(type:collisions,objectType:"boundary",toDo:f=->CollisionResponse.randomBounce(obj3))
obj4.addEvent(type:collisions,objectType:"boundary",toDo:f=->CollisionResponse.randomBounce(obj4))
obj5.addEvent(type:collisions,objectType:"boundary",toDo:f=->CollisionResponse.randomBounce(obj5))

###
animations =
splode:()->
  if @adjustedX < 0 or @adjustedY > 400 or @adjustedX > 400 or @adjustedY < 0# or @adjustedY > 450 or @adjustedY < -50
    console.log @x
    @deleteEvent type:collisions,objectType:"boundary",toDo:f=->CollisionResponse.randomBounce(@)
    @.addEvent(type:collisions,objectType:"boundary",toDo:f=->CollisionResponse.randomBounce(@))
    scene.removeSprite(this)
include(animations,Sprite)

obj1.addAnimation f=->obj1.splode()
obj2.addAnimation f=->obj2.splode()
obj3.addAnimation f=->obj3.splode()
obj4.addAnimation f=->obj4.splode()
obj5.addAnimation f=->obj5.splode()
###
