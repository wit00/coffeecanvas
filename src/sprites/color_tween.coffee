class ColorTween
  constructor:(args={})->
    @attribute = args.attribute ? "x"
    @easeClass = args.ease ? None.easeNone #why do I break if I change @easeClass to @ease?
    @from = args.from ? 0
    @to = args.to ? 100
    @duration = args.duration ? 2000
    @yoyo = args.yoyo ? false
    @elapsed = 0
   
  
   
    
    
