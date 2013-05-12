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
