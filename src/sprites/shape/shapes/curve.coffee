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

