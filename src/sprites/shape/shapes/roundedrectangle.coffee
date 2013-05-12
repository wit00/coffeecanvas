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
