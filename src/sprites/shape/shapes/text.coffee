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
