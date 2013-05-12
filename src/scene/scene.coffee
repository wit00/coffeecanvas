#The scene class is a container class that holds the parent sprites (parent sprites hold sub-sprites)
#and tells the parent sprites to draw and update. Scene also controls the canvas and related context elements
#and passes references to the context to the parent sprites. Scene holds the parent sprites in an array.
#The scene class primarly serves as a way to separate the sceneDirector from the Sprite class, maintaining the #distinction between the API and its implementation.
class Scene
  constructor: (canvas,canvasWidth) ->
    @canvas = document.getElementById "myCanvas"
    @canvasWidth = @canvas.width
    @canvasHeight = @canvas.height
    @context = @canvas.getContext "2d"
    @sprites = []
    
  draw: ->
    for sprite in @sprites
      sprite.runDrawing(@context)
      
  update: ->
    for sprite in @sprites
      sprite.update()
   

  
    
  addSprite: (sprite) ->
    @sprites.push(sprite)
  addSprites:(sprites...)->
    @sprites.push(sprite) for sprite in sprites
    
  #removes a sprite and its children from the display list
  removeSprite:(sprite)->
    index = @sprites.indexOf(sprite)
    @sprites.splice(index,1)  
    collisions.unObserve(sprite)
    #collisions.removeSprite(sprite)
  removeChild:(parentSprite,childSprite)->
    index = parentSprite.subSprites.indexOf(childSprite)
    parentSprite.subSprites.splice(index,1) 
    #collisions.removeSprite(childSprite) #why don't I work?
    collisions.unObserve(childSprite)
  #move this
  #from coffeescriptcookbook.com/chapters/  classes_and_objects/cloning
  clone: (obj) ->
    if not obj? or typeof obj isnt 'object'
      return obj

    if obj instanceof Date
      return new Date(obj.getTime()) 

    if obj instanceof RegExp
      flags = ''
      flags += 'g' if obj.global?
      flags += 'i' if obj.ignoreCase?
      flags += 'm' if obj.multiline?
      flags += 'y' if obj.sticky?
      return new RegExp(obj.source, flags) 

    newInstance = new obj.constructor()

    for key of obj
      if obj.hasOwnProperty(key) 
        newInstance[key] = @clone obj[key] 
        newInstance[key] = obj[key] 

    return newInstance
    

  makeChild: (parentSprite,childSprite) ->
    parentSprite.addChild(childSprite)
    childSprite.adjustedX = childSprite.x + parentSprite.adjustedX
    childSprite.adjustedY = childSprite.y + parentSprite.adjustedY

  clear: =>
    @context.clearRect(0,0,@canvasWidth,@canvasHeight)
    
  attachLinearGradientFill:(sprite,gradient)->
    grad = @context.createLinearGradient(gradient.x1,gradient.y1,gradient.x2,gradient.y2)
    #grad = @context.createLinearGradient(0,0,0,100)
    grad.addColorStop(a[1],a[0]) for a in gradient.colorStops
    sprite.fill = grad
    sprite.createStamp(sprite.stampContext)
    
  attachRadialGradientFill:(sprite,gradient)->
    grad = @context.createRadialGradient(gradient.x1,gradient.y1,gradient.r1,gradient.x2,gradient.y2,gradient.r2)
    grad.addColorStop(a[1],a[0]) for a in gradient.colorStops
    sprite.fill = grad
    sprite.createStamp(sprite.stampContext)
  
  attachPattern:(sprite,pattern)->
    pat = @context.createPattern(pattern.imgId,pattern.repeat)
    sprite.fill = pat
    sprite.createStamp(sprite.stampContext)
  #ToDo: add backgrounds to the Scene to replace or augment the clear function


