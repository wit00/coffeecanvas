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


