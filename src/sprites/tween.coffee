class Tween
  constructor:(args={})->
    @attribute = args.attribute ? "x"
    @easeClass = args.ease ? None.easeNone #why do I break if I change @easeClass to @ease?
    @from = args.from ? 0
    @to = args.to ? 100
    @duration = args.duration ? 2000
    @yoyo = args.yoyo ? false
    @elapsed = 0
    @stop = args.stop ? @duration 
    
  ease:(time)->
  
    @elapsed = @elapsed + time
    #if @elapsed < @duration
    if @elapsed <= @stop
      return @easeClass(@elapsed,@to-@from,@duration,@from)
    else 
      if @yoyo is true
        @reverse()
      else
        return "delete"
        
  reverse:()->
    @elapsed = 0
    to = @to
    from = @from
    @to = from
    @from = to
  
  
   
    
    
