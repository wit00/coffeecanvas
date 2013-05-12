#The game loop class runs the init() function in its constructor to create a game loop.
#The game loop runs, if possible, on a animation frame rate system, which is the optimal frame
#rate chosen by the browser. This system lowers the CPU % used. As a backup, the game loop runs
#a standard setInteval game loop at approximately 60 frames per second.
class GameLoop
  constructor:()->
    @init()
  #should gameLoop, etc. be taken out? 
  init:->
    gameLoop = () ->
      scene.update()
      collisions.onUpdate()
      scene.clear() 
      scene.draw()
    animationFrame = window.requestAnimationFrame or 
      window.webkitRequestAnimationFrame or
      window.mozRequestAnimationFrame or
      window.oRequestAnimationFrame or
      window.msRequestAnimationFrame or
      null;
    if animationFrame != null
      recursiveAnimation = () ->
        gameLoop()
        animationFrame(recursiveAnimation)
      animationFrame(recursiveAnimation)
    if animationFrame is null 
      every = (ms, cb) -> setInterval cb, ms
      every 1000/60, () ->
        gameLoop()
