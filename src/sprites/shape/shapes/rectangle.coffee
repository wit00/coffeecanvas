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
    
