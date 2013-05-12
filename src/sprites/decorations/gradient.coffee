class Gradient
  constructor:(args={})-> 
    @x1 = args.x1 ? 0
    @y1 = args.y1 ? 0
    @x2 = args.x2 ? 60
    @y2 = args.y2 ? 0
    @r1 = args.r1 ? 5
    @r2 = args.r2 ? 60
    @colorStops = args.colorStops ? [["red",1],["blue",0],["white",0.5]]

  makeOptimalVertical:(sprite)->
    @y1 = 0
    @x1 = 0
    @y2 = 0
    if sprite.radius
      @x1 = -sprite.radius - sprite.lineWidth
      @x2 = sprite.radius + sprite.lineWidth
    else
      @x2 = sprite.height 

  makeOptimalHorizontal:(sprite)->
    @x1 = 0
    @y1 = 0
    @x2 = 0
    if sprite.radius
      @y1 = -sprite.radius - sprite.lineWidth
      @y2 = sprite.radius + sprite.lineWidth
    else
      @y2 = sprite.height 
   
  makeOptimalRadial:(sprite)->
    @x1 = 0
    @y1 = 0
    @x2 = 0
    @y2 = 0
    if sprite.radius
      @r1 = sprite.radius/10
      @r2 = sprite.radius
    else
      @r1 = sprite.width/10
      @r2 = sprite.width


