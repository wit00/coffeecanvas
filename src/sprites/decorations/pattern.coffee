class Pattern
  constructor:(args={})->
    @image = args.image
    @repeat = args.repeat ? "repeat"
    @imgId = document.getElementById(@image)
