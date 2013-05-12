class Shape extends Sprite
  constructor:(@x,@y,@rotationVelocity,@velocity,@otherVelocity,@alpha,@rotation,@fill,@stroke,@lineCap,@lineWidth,@lineJoin,@miterLimit,@xVelocity,@yVelocity)-> 
    super(x:@x,y:@y,rotationVelocity:@rotationVelocity,velocity:@velocity,
    otherVelocity:@otherVelocity,alpha:@alpha,lineCap:@lineCap,lineWidth:@lineWidth,
    lineJoin:@lineJoin,miterLimit:@miterLimit,xVelocity:@xVelocity,yVelocity:@yVelocity)
    #default fill is invisible with alpha value 0
    @fill = @fill ? "rgba(0,0,255,0)"
    @stroke = @stroke ? "black"
    
    
  
