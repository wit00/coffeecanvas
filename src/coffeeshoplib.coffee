include = (toInclude,target) ->
  throw('requires a mixin and a target') unless toInclude and target
  for key, value of toInclude
    target::[key] = value


# Namespace is a function written by CoffeeScript creator Jashkenas to emulate namespace or module functionality. 
# The code and following usage examples are taken directly from https://github.com/jashkenas/coffee-script/wiki/FAQ.
# namespace 'Hello.World', (exports) ->
  ## `exports` is where you attach namespace members
# exports.hi = -> console.log 'Hi World!'

# namespace 'Say.Hello', (exports, top) ->
  # #`top` is a reference to the main namespace
  # exports.fn = -> top.Hello.World.hi()
# Say.Hello.fn()  # prints 'Hi World!'

namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

#namespace 'Regular', (exports) ->
  ## `exports` is where you attach namespace members
#  exports.easeOut = -> console.log 'Hi World!'

#namespace 'Say', (exports, top) ->
  # #`top` is a reference to the main namespace
#  exports.fn = -> top.Hello.World.hi()


class ColorTween
  constructor:(args={})->
    @attribute = args.attribute ? "x"
    @easeClass = args.ease ? None.easeNone #why do I break if I change @easeClass to @ease?
    @from = args.from ? 0
    @to = args.to ? 100
    @duration = args.duration ? 2000
    @yoyo = args.yoyo ? false
    @elapsed = 0
   
  
   
    
    
#The matrix class creates the transformation matrix that is applied to the canvas every time a 
#sprite is drawn. I am using it rather than the HTML5 inbuilt transformations because it allows custom 
#transformations by the user. 
class Matrix
 constructor: (@a=1, @b=0, @c=0, @d=1, @e=0, @f=0) ->
    @xScale=1
    @yScale=1
    @xSkew=0
    @ySkew=0
    @xTranslation=0
    @yTranslation=0
    @rotation = 0
  
  makeTransformationMatrix: () ->
    @a = Math.cos(@rotation)*@xScale-Math.sin(@rotation)*@xSkew 
    @b = Math.sin(@rotation)*@xScale + Math.cos(@rotation)*@xSkew
    @c = Math.cos(@rotation)*@ySkew - Math.sin(@rotation)*@yScale
    @d = Math.sin(@rotation)*@ySkew + Math.cos(@rotation)*@yScale
    @e = @xTranslation
    @f = @yTranslation
    
    #ToDo: test if this is faster or slower than running the inbuilt HTML5 rotations, scalings, etc.
#Sprite is the parent class for all of the graphical primitives. 
#Sprite contains an array of sub-sprites, an array of events to perform, an array of received events, 
#and a transformation matrix. Each sprite has standard properties: color,x,y,rotationVelocity,velocity,otherVelocity, 
#alpha,fill,and stroke. 
#Sprites can translate, scale, rotate and skew. 
#Sprites can also addChildren, draw, and update as well as parse, receive, and run events.
class Sprite
  constructor: (args={}) ->
    @x = args.x ? 0
    @y = args.y ? 0
    @angularVelocity = args.angularVelocity ? 0
    @velocity = args.velocity ? 0.5
    @otherVelocity = args.otherVelocity ? 0.3
    @alpha = args.alpha ? 1.0
    @rotation = args.rotation ? 0
    @verticalScale = 1
    @horizontalScale = 1
    @horizontalSkew = 0
    @verticalSkew = 0
    @width = args.width ? 0
    @subSprites = []
    #Possible values for lineCap are "butt", "round", and "square". 
    #The default value is "butt" here and in HTML5.
    @lineCap = args.lineCap ? "butt"
    @lineWidth = args.lineWidth ? 1
    @lineJoin = args.lineJoin ? "miter"
    @miterLimit = args.miterLimit ? 10
    @events = []
    @receivedEvents = {}
    @matrix = new Matrix
    @toDeleteEvents = []
    @boxwidth = 0
    @animations = []
    @collisionEvents = []
    @lastTime = new Date()
    @thisTime = new Date()
    @time = 1
    @xVelocity = args.xVelocity ? 0
    @yVelocity = args.yVelocity ? 0
    @adjustedX = @x
    @adjustedY = @y
    @delta = {x:@adjustedX,y:@adjustedY,hScale:@hScale,vScale:@vScale,hSkew:@hSkew,vSkew:@vSkew,rotation:0}
    @collideTime = 0

  setTime: ()->
    @thisTime = new Date()
    @time = @thisTime.getTime() - @lastTime.getTime()
    @lastTime = @thisTime

  colorTween:(tween)->
    if @fill.length is 15
      red = @fill.substr(5,1)
    if @fill.length is 16
      red = @fill.substr(5,2)
    if @fill.length is 17
      red = @fill.substr(5,3)
    newColor = parseInt(red) + 1
    @changeProperty(fill:'rgba('+newColor.toString()+',0,255,1)')

  tween: (tween)->
    change = tween.ease(@time)
    if change is "delete"
      @toDeleteEvents.push(tween)
    
    else
      switch tween.attribute
        when "x" 
          delt = @x - change
          @x = change
          @adjustedX = change#@adjustedX + delt #fix me
        when "y"
          delt = @y - change
          @y = change
          @adjustedY = change#@adjustedY + delt #fix me
        when "rotation"
          #@matrix.rotation = change
          @rotation = change
        when "alpha"
          @alpha = change
        else attribute = @x#should be an error?
          
  #translate, scale, rotate, and skew, change elements of the sprites matrix to change the overall transformation.
  translate: (vx,vy)->
    vector = Vector.add(@x,@y,vx,vy)
    @x = vector.x
    @y = vector.y
    adjVector = Vector.add(@adjustedX,@adjustedY,vx,vy)
    @adjustedX = adjVector.x
    @adjustedY = adjVector.y
  move:(vx,vy)->
    @x = @x + vx*@time
    @y = @y + vy*@time
    @adjustedX = @adjustedX + vx*@time
    @adjustedY = @adjustedY + vy*@time
  moveTo:(x,y)->
    deltaX = @x - x
    deltaY = @y - y
    @x = x
    @adjustedX = x
    @y = y
    @adjustedY = y
  #for the thesis only#
  oldScale:(x,y)->
    @matrix.xScale = @matrix.xScale + x*(2/4)
    @matrix.yScale = @matrix.yScale + y*(3/4)
  scale:(x,y)  ->
    if @radius
      if x != y
        max = Math.max(x,y)
        @radius = @radius*max
        @width = @width*max
        @height = @height*max
        @matrix.xScale = @matrix.xScale*(x/max)
        @matrix.yScale = @matrix.yScale*(y/max)
      else 
        @radius = @radius*x
        @width = @width*x
        @height = @height*x
    else
      @width = @width*x
      @height = @height*y
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()
    @createStamp(@stampContext)
    for sprite in @subSprites
      sprite.x = sprite.x*x
      sprite.y = sprite.y*y
      sprite.adjustedX = sprite.adjustedX*x
      sprite.adjustedY = sprite.adjustedY*y
      sprite.scale(x,y)
  rotate:(rotation)  ->
    @rotation = @rotation + rotation#*@angularVelocity
    for sprite in @subSprites
      sprite.rotate(rotation)
  skew:(x,y) ->
    @matrix.xSkew = @matrix.xSkew + x#*@otherVelocity
    @matrix.ySkew = @matrix.ySkew + y#*@otherVelocity
    for sprite in @subSprites
      sprite.skew(x,y)
  draw:(context)=>
    #console.log "drawing"
    #for sprite in @subSprites
    #  sprite.draw(context)
  #runDrawing let's me split up the draw function of the graphical primitives and
  #make their code cleaner. There might be a better way to do this.
  runDrawing:(context)=>
    @setupCanvas(context)
    @draw(context)
    @drawSubSprites(context)
    @restoreCanvas(context)
   
  runDrawing2:(context)=>
    @setupCanvas2(context)
    @draw(context)
    @drawSubSprites(context)
    @restoreCanvas(context)  
   
  update: ->
    @runEvents()
    for sprite in @subSprites
      sprite.update() if sprite
    @delta.x = @adjustedX
    @delta.y = @adjustedY
    @delta.rotation = @rotation
    @setTime()
    #x(t) = x(0)+v(0)*t + 1/2*a*t^2
    @x = @x + @xVelocity*@time# + 0.5*@xAcceleration*time*time
    @y = @y + @yVelocity*@time
    @adjustedX = @adjustedX + @xVelocity*@time
    @adjustedY = @adjustedY + @yVelocity*@time
    @rotation = @rotation + @angularVelocity*@time
    @rotation = 0.1 if @rotation > 6.28
    #@delta.x = @adjustedX
    #@delta.y = @adjustedY
    
  addChild: (sprite) =>
    @subSprites.push(sprite) 
  #Here is the event code, in addEvent, parseEvent, runEvents, and receiveEvent. 
  #First, sprites only respond to events that they have subscribed to, such as "keyDown" and "keyUp" events.
  #addEvent is called by the sceneDirector and adds an event, the code (so far only keycodes) and the function
  #attached to those events.
  

  deleteAnimation: (event) ->
    index = @animations.indexOf(event)
    @animations.splice(event,1)
  
  deleteEvent: (event) ->
    index = @events.indexOf(event)
    @events.splice(event,1)
  #When the sprite updates, it runs all of its received events, if any.
  
  run:(event)->
    if typeof event is "function"
      event()
    else
      if event instanceof Tween
        @tween(event)
      if event instanceof ColorTween
        @colorTween(event)
  
  runEvents: ->
    for animation in @animations
      @run(animation)
    for event in @events
      if @receivedEvents[event.code] is true
        @run(event.toDo)
      if event in @collisionEvents
        
        @run(event.toDo)
    @collisionEvents.length = 0
    if @toDeleteEvents.length > 0   
      for event in @toDeleteEvents
        @deleteAnimation(event)
      @toDeleteEvents.length = 0

  #The KeyManager calls receive event when it catches an event. 
  #This function parses the event, checks if it is the correct type, adds it to the received events if it is true, 
  #such as when the key is down, and deletes it when false, such as when the key is up.
  #The receiveEvent function probably needs work, but I want to add more event types first and see what issues come up.
  
  receiveCollisionEvent: (objectHit) ->
    for myEvent in @events
      if myEvent.objectType is "boundary" 
          if objectHit is "boundary"
            @collisionEvents.push(myEvent)
      else if myEvent.type is collisions
        if myEvent.objectType is "all" 
          @collisionEvents.push(myEvent)
        else if objectHit instanceof myEvent.objectType
          @collisionEvents.push(myEvent)
          
  receiveEvent: (e) ->
    for myEvent in @events
      if myEvent.code is e.keyCode 
        if myEvent.action is e.type
          @receivedEvents[e.keyCode] = true
        else
          delete @receivedEvents[e.keyCode]
            
  addAnimation:(toDo)->
    @animations.push(toDo)
  
  addEvent:(args={})->
    type = args.type #throw exception?
    toDo = args.toDo
    type.observe @
    if type instanceof CollisionManager
      objectType = args.objectType ? 'all'
      type.addTypeToTest(@,objectType)
      if args.detail is true
        type.turnOnDetail()  #generate points detail turned on if detail arg is true
      newEvent = 
        type: type
        objectType: objectType
        toDo: toDo
      @events.push(newEvent)
    if type instanceof KeyManager
      newEvent = 
        type: args.type
        action: args.action
        code: args.code 
        toDo: args.toDo
      @events.push(newEvent)  

      
        
  #setupCanvas(context), drawSubSprites(context), and restoreCanvas(context) are drawing functions 
  #needed by every sprite when it draws itself. Those functions are here and inherited by the graphical primitives 
  #in order to clean up the code.
  setupCanvas2: (context) ->
    context.save()
    @matrix.makeTransformationMatrix()
    #In this API, sprites rotate around their center points. 
    #To do this, before drawing the sprite, move the canvas so the sprite is in the center.
    context.translate(@adjustedX,@adjustedY)
    #context.translate(@x,@y)
    context.rotate(@rotation)
    #context.rotate(@rotation) #temp
    #context.transform(@matrix.a,@matrix.b,@matrix.c,@matrix.d,@matrix.e,@matrix.f)
    context.globalAlpha = context.globalAlpha*@alpha
  setupCanvas: (context) ->
    context.save()
    @matrix.makeTransformationMatrix()
    #In this API, sprites rotate around their center points. 
    #To do this, before drawing the sprite, move the canvas so the sprite is in the center.
    #context.translate(@adjustedX,@adjustedY)
    context.translate(@x,@y)
    context.rotate(@rotation)
    #context.rotate(@rotation) #temp
    context.transform(@matrix.a,@matrix.b,@matrix.c,@matrix.d,@matrix.e,@matrix.f)
    context.globalAlpha = context.globalAlpha*@alpha
  drawSubSprites: (context) ->
    for sprite in @subSprites
      sprite.runDrawing(context)
      
  restoreCanvas: (context) ->
    context.restore()
    context.globalAlpha = 1.0
    
  buildDrawingCanvas:()->
    @canvas2 = document.createElement('canvas')
    @canvas2.width = @width + @lineWidth
    @canvas2.height = @height + @lineWidth
    @stampContext = @canvas2.getContext('2d')
    @createStamp(@stampContext)
    
   
  changeProperty:(args={})->
    for own key,value of args
      @[key] = value
    @createStamp(@stampContext)

    

    
class Tween
  constructor:(args={})->
    @attribute = args.attribute ? "x"
    @easeClass = args.ease ? None.easeNone #why do I break if I change @easeClass to @ease?
    @from = args.from ? 0
    @to = args.to ? 100
    @duration = args.duration ? 2000
    @yoyo = args.yoyo ? false
    @elapsed = 0
    @stop = args.stop ? @duration 
    
  ease:(time)->
  
    @elapsed = @elapsed + time
    #if @elapsed < @duration
    if @elapsed <= @stop
      return @easeClass(@elapsed,@to-@from,@duration,@from)
    else 
      if @yoyo is true
        @reverse()
      else
        return "delete"
        
  reverse:()->
    @elapsed = 0
    to = @to
    from = @from
    @to = from
    @from = to
  
  
   
    
    
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
      
namespace 'None', (exports) ->
  exports.easeNone = (elapsed,change,duration,from) ->
    elapsed*(change/duration) + from
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
      
      
namespace 'Strong', (exports) ->
  exports.easeIn = (elapsed,change,duration,from)->
    (change)*(elapsed/=duration)*elapsed*elapsed*elapsed*elapsed*elapsed + from
  exports.easeOut = (elapsed,change,duration,from) ->
    -change*((elapsed = elapsed/duration-1)*elapsed*elapsed*elapsed-1) + from
  exports.easeInOut = (elapsed,change,duration,from)->
    if((elapsed/=duration/2) < 1)
      return (change/2)*elapsed*elapsed*elapsed*elapsed*elapsed + from 
    else
      #return (-change/2)*(elapsed-=2)*elapsed*elapsed*elapsed*elapsed*elapsed + from
      return (-change/2)*((elapsed -= 2)*elapsed*elapsed*elapsed-2) + from
      
class Shape extends Sprite
  constructor:(@x,@y,@rotationVelocity,@velocity,@otherVelocity,@alpha,@rotation,@fill,@stroke,@lineCap,@lineWidth,@lineJoin,@miterLimit,@xVelocity,@yVelocity)-> 
    super(x:@x,y:@y,rotationVelocity:@rotationVelocity,velocity:@velocity,
    otherVelocity:@otherVelocity,alpha:@alpha,lineCap:@lineCap,lineWidth:@lineWidth,
    lineJoin:@lineJoin,miterLimit:@miterLimit,xVelocity:@xVelocity,yVelocity:@yVelocity)
    #default fill is invisible with alpha value 0
    @fill = @fill ? "rgba(0,0,255,0)"
    @stroke = @stroke ? "black"
    
    
  
class Gradient
  constructor:(args={})-> 
    @x1 = args.x1 ? 0
    @y1 = args.y1 ? 0
    @x2 = args.x2 ? 60
    @y2 = args.y2 ? 0
    @r1 = args.r1 ? 5
    @r2 = args.r2 ? 60
    @colorStops = args.colorStops ? [["red",1],["blue",0],["white",0.5]]

  makeOptimalVertical:(sprite)->
    @y1 = 0
    @x1 = 0
    @y2 = 0
    if sprite.radius
      @x1 = -sprite.radius - sprite.lineWidth
      @x2 = sprite.radius + sprite.lineWidth
    else
      @x2 = sprite.height 

  makeOptimalHorizontal:(sprite)->
    @x1 = 0
    @y1 = 0
    @x2 = 0
    if sprite.radius
      @y1 = -sprite.radius - sprite.lineWidth
      @y2 = sprite.radius + sprite.lineWidth
    else
      @y2 = sprite.height 
   
  makeOptimalRadial:(sprite)->
    @x1 = 0
    @y1 = 0
    @x2 = 0
    @y2 = 0
    if sprite.radius
      @r1 = sprite.radius/10
      @r2 = sprite.radius
    else
      @r1 = sprite.width/10
      @r2 = sprite.width


class Pattern
  constructor:(args={})->
    @image = args.image
    @repeat = args.repeat ? "repeat"
    @imgId = document.getElementById(@image)
#Bitmap takes draws a bitmap, png, jpg, or svg file that is loaded into the html.
#Bitmap requires the image id from the html.
class Bitmap extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @image = document.getElementById(args.image)
    @width = @image.width
    @height = @image.height
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    #@buildDrawingCanvas()
  createStamp: (context) ->
  draw:(context)->
    context.drawImage(@image,@centerPoint.x,@centerPoint.y)
    #context.drawImage(@image,30,30)
  #toDo: what to do if not imgId given?
#Circle draws a filled or empty circle with or without an outline. 
#Circle has one additional argument, radius.
class Circle extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @radius = args.radius ? 30
    @width = @radius*2 
    @height = @radius*2 
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()
    
  createStamp: (context) ->
    context.translate(@width/2+@lineWidth/2,@height/2+@lineWidth/2)
    context.lineCap = @lineCap
    context.lineJoin = @lineJoin
    context.lineWidth = @lineWidth
    context.miterLimit = @miterLimit
    context.fillStyle = @fill 
    context.strokeStyle = @stroke
    context.beginPath()
    context.arc(0,0,@radius,0,Math.PI*2,true)
    context.fill()
    context.stroke()
    context.closePath()
    context.translate(-@width/2-@lineWidth/2,-@height/2-@lineWidth/2)
  draw:(context)->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y)
#The line class draws a line from on point (x,y) to another point (toX,toY).
class Curve extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @cp1x = args.cp1x ? 0
    @cp1y = args.cp1y ? 0
    @cp2x = args.cp2x ? "none"
    @cp2y = args.cp2y ? "none"
    @toX = args.toX ? 100
    @toY = args.toY ? 100 
    canvas = document.getElementById "myCanvas"
    @width = canvas.width#Math.abs(@x - @toX)
    @height = canvas.height#Math.abs(@y - @toY)
    
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()
    
  createStamp: (context) ->
    context.strokeStyle = @stroke
    context.beginPath()
    context.moveTo(@x,@y)
    if @cp2x and @cp2y isnt "none"
      context.bezierCurveTo(@cp1x,@cp1y,@cp2x,@cp2y,@toX,@toY) 
    else
      context.quadraticCurveTo(@cp1x,@cp1y,@toX,@toY)
    context.stroke()
    context.closePath()
  draw:(context)->
    context.drawImage(@canvas2,0,0)#@centerPoint.x,@centerPoint.y)

#The line class draws a line from on point (x,y) to another point (toX,toY).
class Line extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @toX = args.toX ? 0
    @toY = args.toY ? 0
    @width = Math.abs(@x - @toX)*2
    @height = Math.abs(@y - @toY)*2
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()
    
  createStamp: (context) ->
    context.translate(@width/2+@lineWidth/2,@height/2+@lineWidth/2)
    context.strokeStyle = @stroke
    context.beginPath()
    context.translate(-@x,-@y)
    context.moveTo(@x,@y)
    context.lineTo(@toX,@toY)
    context.closePath()
    context.stroke()
    #context.fill()
    context.translate(-@width/2-@lineWidth/2,-@height/2-@lineWidth/2)
  draw:(context)->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y)

#Polygon is a graphical primitive of my design, created using inherit JavaScript/HTML5 functions.
#Polygon creates an n-gon determined by the sides argument and the radius argument.
class Polygon extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @radius = args.radius ? 30
    @sides = args.sides ? 5
    @width = @radius*2
    @height = @radius*2
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}  
    @buildDrawingCanvas()
    
  #The polygon is drawn by rotating the canvas 2PI/(number of sides) radians and drawing a line radius length 
  #from the center.
  createStamp: (context) ->
    context.translate(@width/2+@lineWidth/2,@height/2+@lineWidth/2)
    context.lineCap = @lineCap
    context.lineJoin = @lineJoin
    context.lineWidth = @lineWidth
    context.miterLimit = @miterLimit
    context.save()
    radians = 2*Math.PI/@sides
    context.beginPath()
    context.moveTo(0,-@radius)
    for side in [0...@sides]
      context.rotate(radians)
      context.lineTo(0,-@radius)
    context.fillStyle = @fill
    context.strokeStyle = @stroke
    context.stroke()
    context.fill()
    context.closePath()
    context.restore()
    context.translate(-@width/2-@lineWidth/2,-@height/2-@lineWidth/2)
  draw:(context)->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y)
#Rectangle is a class created around the standard HTML5/JavaScript functions for creating rectangles on the canvas.
#The major differences is that the center of my rectangle is the x,y coordinate. In the standard canvas element, 
#the x,y coordinate marks the upper-left hand corner, which I find confusing.
class Rectangle extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @width = args.width ? 40
    @height = args.height ? 70
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()
    
    
  createStamp: (context) ->
    #Make the center of the rectangle the x,y coordinate by translating over half of the width and half of the length.
    context.translate(@width/2+@lineWidth/2,@height/2+@lineWidth/2)
    context.lineCap = @lineCap
    context.lineJoin = @lineJoin
    context.lineWidth = @lineWidth
    context.miterLimit = @miterLimit
    context.translate(-(@width/2),-(@height/2))
    context.fillStyle = @fill
    context.strokeStyle = @stroke
    #context.beginPath()
    #context.rect(-@width/2-@lineWidth/2,-@height/2-@lineWidth/2,@width,@height)
    context.rect(0,0,@width,@height)
    context.fill()
    context.stroke()
    #context.closePath()
    context.translate((@width/2),(@height/2))
    context.translate(-@width/2-@lineWidth/2,-@height/2-@lineWidth/2)
  draw:(context)->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y)


  attachLinearGradientFill:(gradient)->
    #grad = @context.createLinearGradient(gradient.x1,gradient.y1,gradient.x2,gradient.y2)
    grad = @stampContext.createLinearGradient(0,0,0,30)
    #grad.addColorStop(a[1],a[0]) for a in gradient.colorStops
    grad.addColorStop(0,"black")
    grad.addColorStop(0.5,"white")
    grad.addColorStop(1,"blue")
    @fill = grad
    @createStamp(@stampContext)
    
#Rounded Rectangle is one of my primitives.
#It is drawn using the moveTo, lineTo, and arcTo functions in the HTML5 library.
#It takes in the special arguments width, height, and arcRadius.
class RoundedRectangle extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @width = args.width ? 100
    @height = args.height ? 100
    @arcRadius = args.arcRadius ? 10
    @centerPoint = {x:-@width/2-@lineWidth/2+@arcRadius/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()

  createStamp: (context) ->
    #The width of the rectangle goes from edge to edge, but the drawing code needs the width between 
    #the two arcRadius corner lengths on either side. Width is redefined here to be faster and help 
    #code redability. The same goes for the height.
    context.translate(@width/2+@lineWidth/2,@height/2+@lineWidth/2)
    context.fillStyle = @fill
    context.strokeStyle = @stroke
    width = @width - (2*@arcRadius)
    height = @height - (2*@arcRadius)
    
    
    
    arcRadius = @arcRadius
    context.translate(-(@width/2),-(@height/2))
    context.beginPath()  
    context.moveTo(arcRadius,0)
    context.lineTo(width,0)
    context.arcTo(width+arcRadius,0,width+arcRadius,arcRadius,arcRadius)
    context.lineTo(width+arcRadius,arcRadius+height)
    context.arcTo(width+arcRadius,height+(2*arcRadius),width,height+(2*arcRadius),arcRadius)
    context.lineTo(arcRadius,height+(2*arcRadius))
    context.arcTo(0,height+(2*arcRadius),0,height+arcRadius,arcRadius)
    context.lineTo(0,arcRadius)
    context.arcTo(0,0,arcRadius,0,arcRadius)
    context.fill()
    context.stroke()
    context.translate((@width/2),(@height/2))
    context.translate(-@width/2-@lineWidth/2,-@height/2-@lineWidth/2)
    
  draw:(context)->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y)
#Square is a primitive that I designed. It's a modified rectangle. Like my rectangle class, its x,y coordinate marks
#its center rather than the upper left corner.
class Square extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @lineWidth = args.lineWidth ? 1
    @width = args.width ? 30
    @height = @width
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()
  createStamp: (context) ->
    context.translate(this.width/2+@lineWidth/2,this.height/2+@lineWidth/2)
    context.translate(-(@width/2),-(@height/2))
    context.fillStyle = @fill
    context.strokeStyle = @stroke
    context.beginPath()
    context.rect(0,0,@width,@height)
    context.fill()
    context.stroke()
    context.closePath()
    context.translate((@width/2),(@height/2))
    context.translate(-this.width/2-@lineWidth/2,-this.height/2-@lineWidth/2)
    
  draw:(context)->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y)

#Star is one of my primitives. 
#Star creates an n-star from a sides and a radius variable. 
#The standard number of points is five.
class Star extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @radius = args.radius ? 30
    @sides = args.sides ? 5
    @width = @radius*2
    @height = @width
    @lineWidth = args.lineWidth ? 1
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}
    @buildDrawingCanvas()
  
  #The star is drawn by rotating PI/sides and drawing lines radius and 0.5*radius out from the center.
  createStamp: (context) ->
    context.translate(this.height/2+@lineWidth,this.width/2+@lineWidth)
    context.lineCap = @lineCap
    context.lineJoin = @lineJoin
    context.lineWidth = @lineWidth
    context.miterLimit = @miterLimit
    context.save()
    radians = Math.PI/@sides
    context.beginPath()
    context.moveTo(0,-@radius)
    for side in [0...@sides]
      context.rotate(radians)
      context.lineTo(0,-0.5*@radius)
      context.rotate(radians)
      context.lineTo(0,-@radius)
    context.fillStyle = @fill
    context.strokeStyle = @stroke
    context.fill()
    context.stroke()
    context.closePath()
    context.restore()
    context.translate(-this.height/2-@lineWidth,-this.width/2-@lineWidth)
    
  draw:(context)->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y)

#Text is a standard HTML5/JavaScript primitive.
#The text class takes the special arguments: text, style, variant, weight, size, and family.
class Text extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @text = args.text ? "Hello World!"
    @fill = args.fill ? "black"
    @style = args.style ? "normal "
    @variant = args.variant ? "normal "
    @weight = args.weight ? "normal "
    @size = args.size ? "12px "
    @family = args.family ? " sans-serif "
    @findWidth()
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()
    
  createStamp: (context) ->
    context.translate(@width/2+@lineWidth/2,@height/2+@lineWidth/2)
    context.fillStyle = @fill
    font = @style+@variant+@weight+@size+@family
    context.font = font
    context.fillText(@text,-@width/2,0)
    context.translate(-@width/2-@lineWidth/2,-@height/2-@lineWidth/2)
  draw: (context) ->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y)

  findWidth:()-> #find the width of the text by drawing it on a blank canvas. The height is only a guess, hopefully <= width
    tempCanvas = document.createElement('canvas')
    tempCanvas.width = scene.canvasWidth ? 500
    tempCanvas.height = scene.canvasHeight ? 500
    tempContext = tempCanvas.getContext('2d')
    tempContext.font = @style+@variant+@weight+@size+@family
    @width = tempContext.measureText(@text).width 
    @height = @width
    
    #@createStamp(@stampContext)
#The triangle creates a triangle using 3 points.
#The triangle is also one of my graphical primitives created using the standard functions.
class Triangle extends Shape
  constructor:(args = {})-> 
    super(args.x,args.y,args.angularVelocity,args.velocity,args.otherVelocity,
    args.alpha,args.rotation,args.fill,args.stroke,args.lineCap,args.lineWidth,args.lineJoin,args.miterLimit,args.xVelocity,args.yVelocity)
    @width = args.width ? 400
    @height = args.height ? 400
    @lineWidth = 2
    ###
    @x1 = args.x1 ? 10
    @y1 = args.y1 ? 10
    @x2 = args.x2 ? 0
    @y2 = args.y2 ? 20
    @x3 = args.x3 ? 20
    @y3 = args.y3 ? 20
    @x = @x1
    @y = @y1
    ###
    #@width = Math.abs(@x2-@x1)
    #@height = Math.abs(@y1-@y3)
    @centerPoint = {x:-@width/2-@lineWidth/2,y:-@height/2-@lineWidth/2}    
    @buildDrawingCanvas()
    
  createStamp: (context) ->
    context.translate(@width/2+@lineWidth/2,0)#@height/2+@lineWidth/2)
    context.lineCap = @lineCap
    context.lineJoin = @lineJoin
    context.lineWidth = @lineWidth
    context.miterLimit = @miterLimit
    context.fillStyle = @fill
    context.strokeStyle = @stroke
    context.beginPath()
    context.moveTo(0,0)
    context.lineTo(@width/2,@height)
    context.lineTo(-@width/2,@height)
    context.lineTo(0,0)
    context.fill()
    context.stroke()
    context.closePath()
    context.translate(-@width/2-@lineWidth,0)#-@height/2-@lineWidth)
  draw:(context)->
    context.drawImage(@canvas2,@centerPoint.x,@centerPoint.y )


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
  
class CollisionManager
  constructor: (scene) ->
    @checkCollision = []
    @collided = []
    @typesToTest = {}
    @scene = scene
    @detail = false
    
  #new function for setting the detail from generate points 
  turnOnDetail: () ->
    @detail = true
    
  onUpdate: (event) ->
    for sprite in @checkCollision 
      @runCollisionDetection(sprite)
    for sprite in @collided
      from = sprite.o1
      collisionEvent = {type:"collision",keyCode:sprite.o2}
      from.receiveCollisionEvent(sprite.o2)
    @collided = []
    
  observe: (sprite) ->
    @checkCollision.push sprite if sprite not in @checkCollision
  
  unObserve:(sprite)->
    index = @checkCollision.indexOf(sprite)
    @checkCollision.splice(index,1)    
   
  addTypeToTest: (sprite,type)->
    if @typesToTest.sprite
      @typesToTest.sprite.push(type) 
    else
      @typesToTest.sprite = [type]
   
  pixelByPixel:(xMax,xMin,yMax,yMin,o1,o2)->
    xDiff = xMax - xMin
    yDiff = yMax - yMin 
    canvas = document.getElementById "myCanvas"
    canvas2 = document.createElement('canvas')
    canvas2.width = canvas.width
    canvas2.height = canvas.height
    tempContext = canvas2.getContext('2d')
    o1.runDrawing2(tempContext)
    imgData1 = tempContext.getImageData(xMin,yMin,xDiff,yDiff)
    pixels1 = imgData1.data
    tempContext.clearRect(0,0,canvas2.width,canvas2.height)
    o2.runDrawing(tempContext)
    imgData2 = tempContext.getImageData(xMin,yMin,xDiff,yDiff)
    pixels2 = imgData2.data
    for pixel1 in pixels1 by 3
      for pixel2 in pixels2 by 3
        if pixel1 > 0 and pixel2 > 0
          if @detail is true
            @generatePoints(xDiff,yDiff,xMin,yMin,o1,o2)
            return true
          else
            return true
    return false   
    
  detectCollisions:(o1,o2)->
    side1 = Math.max(o1.width+(2*o1.lineWidth),o1.height+(2*o1.lineWidth))
    side2 = Math.max(o2.width+(2*o2.lineWidth),o2.height+(2*o2.lineWidth))
    x = Math.round(o1.adjustedX)+(o1.lineWidth)
    y = Math.round(o1.adjustedY)+(o1.lineWidth)
    x2 = Math.round(o2.adjustedX)+(o2.lineWidth)
    y2 = Math.round(o2.adjustedY)+(o2.lineWidth)
    x -= (side1/2 + 0.5) << 0#x -= (o1.width/2 + 0.5) << 0
    y -= (side1/2 + 0.5) << 0#y -= (o1.height/2 + 0.5) << 0
    x2 -= (side2/2 + 0.5) << 0 #x2 -= (o2.width/2 + 0.5) << 0
    y2 -= (side2/2 + 0.5) << 0 #y2 -= (o2.height/2 + 0.5) << 0
    xMin = Math.max(x,x2)
    yMin = Math.max(y,y2)
    xMax = Math.min(x+o1.width,x2+o2.width+o1.lineWidth+o2.lineWidth)
    yMax = Math.min(y+o1.height,y2+o2.height+o1.lineWidth+o2.lineWidth)
    if(xMin >= xMax) or (yMin >= yMax)
      return false
    else #pixel-by-pixel
      @pixelByPixel(xMax,xMin,yMax,yMin,o1,o2)
  notOnCanvas:(sprite)->
    canvasObject = new Rectangle(x:scene.canvasWidth/2,y:scene.canvasHeight/2,width:scene.canvasWidth,height:scene.canvasHeight)  
    opposite = @detectCollisions(sprite,canvasObject)    
    return true if opposite is false
    return false if opposite is true 
    
  
    
 
  detectAtTime:(xDiff,yDiff,xMin,yMin,o1,o2,moment)->
    canvas = document.getElementById "myCanvas"
    w = xDiff - xMin
    h = yDiff - yMin
    tempCanvas = document.createElement "canvas"
    tempCanvas.width = 500#canvas.width
    tempCanvas.height = 500#canvas.height 
    tempContext = tempCanvas.getContext "2d"
    tempContext.save()
    o1.setupCanvas(tempContext)
    tempContext.translate((o1.adjustedX-o1.delta.x)*moment,(o1.adjustedY-o1.delta.y)*moment) 
    tempContext.rotate((o1.rotation-o1.delta.rotation)*moment)
    o1.draw(tempContext)
    imgData1 = tempContext.getImageData(xMin,yMin,xDiff,yDiff)
    pixels1 = imgData1.data
    tempContext.restore()
    tempContext.clearRect(0,0,500,500)
    o2.setupCanvas(tempContext)
    tempContext.rotate((o1.rotation-o1.delta.rotation)*moment)
    tempContext.translate((o2.adjustedX-o2.delta.x)*moment,(o2.adjustedY-o2.delta.y)*moment)
    o2.draw(tempContext)
    imgData2 = tempContext.getImageData(xMin,yMin,xDiff,yDiff)
    pixels2 = imgData2.data
    return {pixels1:pixels1,pixels2:pixels2}
    
    
  collidesAtTime:(xDiff,yDiff,xMin,yMin,o1,o2,moment)->
    pixels = @detectAtTime(xDiff,yDiff,xMin,yMin,o1,o2,moment)
    for pixel1 in pixels.pixels1 by 3
      for pixel2 in pixels.pixels2 by 3
        if pixel1 > 0 and pixel2 > 0
          return true
    return false   
    
  makePointsList:(xDiff,yDiff,xMin,yMin,o1,o2,moment)->
    list = []
    pixels = @detectAtTime(xDiff,yDiff,xMin,yMin,o1,o2,moment)
    x = 0
    y = 0
    for pixel1 in pixels.pixels1 by 3
      for pixel2 in pixels.pixels2 by 3
        if x >= xDiff 
          x = 0
          y = y + 1
        else
          x = x + 1
        if pixel1 > 0 and pixel2 > 0
          list.push ([x+xMin,y+yMin])
          if list.length > 10
            return list
  
  drawAtCollide:(o,time)->
   
    o.rotation = o.rotation - ((o.rotation-o.delta.rotation)*time)
    o.x = o.x - ((o.x-o.delta.x)*time)
    o.y = o.y - ((o.y-o.delta.y)*time)
    o.adjustedX = o.adjustedX - ((o.adjustedX-o.delta.x)*time)
    o.adjustedY = o.adjustedY - ((o.adjustedY-o.delta.y)*time)
    
    
  generatePoints:(xDiff,yDiff,xMin,yMin,o1,o2)-> 
    min = 0
    max = o1.time-1
    mid = 0
    midValue = true
    time = o1.time
    isColliding = true
    while min <= max
      mid = Math.floor((min+max)/2)
      moment = mid/time
      isColliding = @collidesAtTime(xDiff,yDiff,xMin,yMin,o1,o2,moment)#collision at time
      if isColliding is false
        min = mid + 1
      if isColliding is true
        max = mid - 1
    if isColliding is true #find points at mid
      o1.collideTime = mid
      @drawAtCollide(o1,mid/o1.time+1)
      #return true
    else #find points at mid + 1
      o1.collideTime = mid + 1
      @drawAtCollide(o1,(mid+1)/o1.time+1)
      return true
      
      
  moveBackBoundary:(o1)-> 
    min = 0
    max = o1.time-1
    mid = 0
    midValue = true
    time = o1.time
    isColliding = true
    while min <= max
      mid = Math.floor((min+max)/2)
      moment = mid/time
      isColliding = @testBound(o1,moment)#collision at time
      if isColliding is false
        min = mid + 1
      if isColliding is true
        max = mid - 1
    if isColliding is true #find points at mid
      o1.collideTime = mid
      @drawAtCollide(o1,mid/o1.time+1)
      return true
    else #find points at mid + 1
      o1.collideTime = mid + 1
      @drawAtCollide(o1,(mid+1)/o1.time+1)
      return true
 
    
  testBound:(o1,moment)-> #does not account for rotation!
    canvas = document.getElementById "myCanvas"
    y = o1.adjustedY + (o1.adjustedY-o1.delta.y)*moment
    
    x = o1.adjustedX + (o1.adjustedX-o1.delta.x)*moment
    h = o1.height
    w = o1.width
    yMin = y - (h/2)
    yMax = y + (h/2)
    xMin = x - (w/2)
    xMax = x + (w/2)
    if xMin <= 0
      return true
    else if xMax >= canvas.width  
      return true
    else if yMax >= canvas.height
      return true
    else if yMin <= 0
      return true  
    console.log "false" 
    return false
  hitsBoundary:(sprite)->
    canvas = document.getElementById "myCanvas"
    
    if sprite instanceof Circle
      radius = sprite.radius
      if sprite.adjustedX + radius >= canvas.width
        return true
      if sprite.adjustedX - radius <= 0
        return true
      if sprite.adjustedY + radius >= canvas.height
        return true
      if sprite.adjustedY - radius <= 0
        return true
    else
      y = sprite.adjustedY
      x = sprite.adjustedX
      h = sprite.height
      w = sprite.width
      yMin = y - (h/2)
      yMax = y + (h/2)
      xMin = x - (w/2)
      xMax = x + (w/2)
      if xMin < 0
        return true
      else if xMax >= canvas.width  
        return true
      else if yMax >= canvas.height
        return true
      else if yMin < 0
        return true
  runCollisionDetection:(sprite) ->
    for type in @typesToTest.sprite
      if type is "boundary"
        if @hitsBoundary(sprite) is true
          @moveBackBoundary(sprite)
          #console.log "made it here"
          #@drawAtCollide(sprite,.5)
          @collided.push({o1:sprite,o2:"boundary"}) 
    index = @scene.sprites.indexOf(sprite)
    isCorrectType = false
    for object in @scene.sprites#@allSprites
      #for type in @typesToTest.sprite
      #if object instanceof Circle
        #if object instanceof type for type in @typesToTest.sprite
        #console.log object
      isCorrectType = true
        #if type is "boundary"
        #  isCorrectType = false
        #else if type is "all" or object instanceof type
        #  isCorrectType = true
     # if isCorrectType
     #   if (index isnt @scene.sprites.indexOf(object))
     #     collision = @detectCollisions(sprite,object)
          #@collided.push({o1:sprite,o2:object}) if collision is true
    for subSprite in sprite.subSprites
      @runCollisionDetection(subSprite)

#The game loop class runs the init() function in its constructor to create a game loop.
#The game loop runs, if possible, on a animation frame rate system, which is the optimal frame
#rate chosen by the browser. This system lowers the CPU % used. As a backup, the game loop runs
#a standard setInteval game loop at approximately 60 frames per second.
class GameLoop
  constructor:()->
    @init()
  #should gameLoop, etc. be taken out? 
  init:->
    gameLoop = () ->
      scene.update()
      collisions.onUpdate()
      scene.clear() 
      scene.draw()
    animationFrame = window.requestAnimationFrame or 
      window.webkitRequestAnimationFrame or
      window.mozRequestAnimationFrame or
      window.oRequestAnimationFrame or
      window.msRequestAnimationFrame or
      null;
    if animationFrame != null
      recursiveAnimation = () ->
        gameLoop()
        animationFrame(recursiveAnimation)
      animationFrame(recursiveAnimation)
    if animationFrame is null 
      every = (ms, cb) -> setInterval cb, ms
      every 1000/60, () ->
        gameLoop()
#KeyManager follows a variation on the JavaScript Subscriber/Observer pattern, and sends keyboard events
#to the sprites that subscribe to keyboard events. When a sprite subscribes to keyboard events, the 
#sceneDirector calls the observe(sprite) method, which adds the sprite to the KeyManager sprites array. Every time a #key is pressed, the event is passed to all of subscribing sprites, with the bool true if the key is down and false #when the key is released (is up). Changing the up/down state in this way is a standard way to create smooth #animations.
class KeyManager
  constructor: ->
    document.addEventListener("keydown",(listener=(event)->keys.onKeyDown(event)),false)
    document.addEventListener("keyup",(listener=(event)->keys.onKeyUp(event)),false)
    @sprites = []
  onKeyDown: (event) -> 
    sprite.receiveEvent(event) for sprite in @sprites
  onKeyUp: (event) -> 
    sprite.receiveEvent(event) for sprite in @sprites
  observe: (sprite) ->
    @sprites.push(sprite)

  #ToDo: Add the ability to this class or elsewhere to have non-smooth animations.
#The scene class is a container class that holds the parent sprites (parent sprites hold sub-sprites)
#and tells the parent sprites to draw and update. Scene also controls the canvas and related context elements
#and passes references to the context to the parent sprites. Scene holds the parent sprites in an array.
#The scene class primarly serves as a way to separate the sceneDirector from the Sprite class, maintaining the #distinction between the API and its implementation.
class Scene
  constructor: (canvas,canvasWidth) ->
    @canvas = document.getElementById "myCanvas"
    @canvasWidth = @canvas.width
    @canvasHeight = @canvas.height
    @context = @canvas.getContext "2d"
    @sprites = []
    
  draw: ->
    for sprite in @sprites
      sprite.runDrawing(@context)
      
  update: ->
    for sprite in @sprites
      sprite.update()
   

  
    
  addSprite: (sprite) ->
    @sprites.push(sprite)
  addSprites:(sprites...)->
    @sprites.push(sprite) for sprite in sprites
    
  #removes a sprite and its children from the display list
  removeSprite:(sprite)->
    index = @sprites.indexOf(sprite)
    @sprites.splice(index,1)  
    collisions.unObserve(sprite)
    #collisions.removeSprite(sprite)
  removeChild:(parentSprite,childSprite)->
    index = parentSprite.subSprites.indexOf(childSprite)
    parentSprite.subSprites.splice(index,1) 
    #collisions.removeSprite(childSprite) #why don't I work?
    collisions.unObserve(childSprite)
  #move this
  #from coffeescriptcookbook.com/chapters/  classes_and_objects/cloning
  clone: (obj) ->
    if not obj? or typeof obj isnt 'object'
      return obj

    if obj instanceof Date
      return new Date(obj.getTime()) 

    if obj instanceof RegExp
      flags = ''
      flags += 'g' if obj.global?
      flags += 'i' if obj.ignoreCase?
      flags += 'm' if obj.multiline?
      flags += 'y' if obj.sticky?
      return new RegExp(obj.source, flags) 

    newInstance = new obj.constructor()

    for key of obj
      if obj.hasOwnProperty(key) 
        newInstance[key] = @clone obj[key] 
        newInstance[key] = obj[key] 

    return newInstance
    

  makeChild: (parentSprite,childSprite) ->
    parentSprite.addChild(childSprite)
    childSprite.adjustedX = childSprite.x + parentSprite.adjustedX
    childSprite.adjustedY = childSprite.y + parentSprite.adjustedY

  clear: =>
    @context.clearRect(0,0,@canvasWidth,@canvasHeight)
    
  attachLinearGradientFill:(sprite,gradient)->
    grad = @context.createLinearGradient(gradient.x1,gradient.y1,gradient.x2,gradient.y2)
    #grad = @context.createLinearGradient(0,0,0,100)
    grad.addColorStop(a[1],a[0]) for a in gradient.colorStops
    sprite.fill = grad
    sprite.createStamp(sprite.stampContext)
    
  attachRadialGradientFill:(sprite,gradient)->
    grad = @context.createRadialGradient(gradient.x1,gradient.y1,gradient.r1,gradient.x2,gradient.y2,gradient.r2)
    grad.addColorStop(a[1],a[0]) for a in gradient.colorStops
    sprite.fill = grad
    sprite.createStamp(sprite.stampContext)
  
  attachPattern:(sprite,pattern)->
    pat = @context.createPattern(pattern.imgId,pattern.repeat)
    sprite.fill = pat
    sprite.createStamp(sprite.stampContext)
  #ToDo: add backgrounds to the Scene to replace or augment the clear function


