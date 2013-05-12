#KeyManager follows a variation on the JavaScript Subscriber/Observer pattern, and sends keyboard events
#to the sprites that subscribe to keyboard events. When a sprite subscribes to keyboard events, the 
#sceneDirector calls the observe(sprite) method, which adds the sprite to the KeyManager sprites array. Every time a #key is pressed, the event is passed to all of subscribing sprites, with the bool true if the key is down and false #when the key is released (is up). Changing the up/down state in this way is a standard way to create smooth #animations.
class KeyManager
  constructor: ->
    document.addEventListener("keydown",(listener=(event)->keys.onKeyDown(event)),false)
    document.addEventListener("keyup",(listener=(event)->keys.onKeyUp(event)),false)
    @sprites = []
  onKeyDown: (event) -> 
    sprite.receiveEvent(event) for sprite in @sprites
  onKeyUp: (event) -> 
    sprite.receiveEvent(event) for sprite in @sprites
  observe: (sprite) ->
    @sprites.push(sprite)

  #ToDo: Add the ability to this class or elsewhere to have non-smooth animations.
