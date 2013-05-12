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

