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

