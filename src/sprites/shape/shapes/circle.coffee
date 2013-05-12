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
