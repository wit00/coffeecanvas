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

