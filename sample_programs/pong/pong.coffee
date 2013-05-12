scene = new Scene
gameLoop = new GameLoop
keys = new KeyManager
collisions = new CollisionManager(scene)

ball = new Circle(radius:20,x:200,y:200,alpha:0.4,fill:"yellow",lineWidth:1,xVelocity:0,yVelocity:0)
paddle1 = new RoundedRectangle(x:380,y:200,width:50,height:70,stroke:"purple")
paddle2 = new RoundedRectangle(x:20,y:200,width:50,height:70,stroke:"red")
scene.addSprite(paddle1)
scene.addSprite(paddle2)
scene.addSprite(ball)
animations = 
  changeVelocity:()->
    CollisionResponse.moveBeforeCollision(this)
    @xVelocity = @xVelocity*-1
    if @y >= 200
      @yVelocity = -0.1
    else
      @yVelocity = 0.1
  crash:()->
    alert "Crash!"
    @moveTo(200,200)
    @xVelocity = 0
    @yVelocity = 0
include(animations, Sprite)

ball.addEvent(type:collisions,objectType:"boundary",toDo:f=->ball.crash())
ball.addEvent(type:collisions,objectType:RoundedRectangle,toDo:f=->ball.changeVelocity())
ball.addEvent(type:keys,action:"keydown",code:13,toDo:f=->ball.xVelocity = 0.5)
paddle1.addEvent(type:keys,action:"keydown",code:87,toDo:f=->paddle1.move 0,-.5)
paddle1.addEvent(type:keys,action:"keydown",code:83,toDo:f=->paddle1.move 0,.5)
paddle2.addEvent(type:keys,action:"keydown",code:87,toDo:f=->paddle2.move 0,-.5)
paddle2.addEvent(type:keys,action:"keydown",code:83,toDo:f=->paddle2.move 0,.5)

