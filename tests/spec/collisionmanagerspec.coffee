describe 'CollisionManager', ->
  cm = 
  beforeEach ->
    canvas = document.createElement('canvas')
    canvas.width = 100
    canvas.height = 100
    canvas.id = "myCanvas"
    document.body.appendChild(canvas)
    cm = new CollisionManager
  describe 'Constructor', ->
    it 'CollisionManager is defined', ->
      expect(cm).toBeDefined()
    it 'checkCollision Array is Defined and Empty',->
      expect(cm.checkCollision).toBeDefined()
      expect(cm.checkCollision.length).toBe(0)
    it 'collided Array is Defined and Empty',->
      expect(cm.collided).toBeDefined()
      expect(cm.collided.length).toBe(0)
  describe 'Observe Functions', ->
    it "Observe Function adds sprite to checkCollision Array",->
      expect(cm.checkCollision.length).toBe(0)
      cm.observe(new Sprite)
      expect(cm.checkCollision.length).toBe(1)
    it "Observe Function does not add sprite to checkCollision Array if it is already in checkCollision",->
      expect(cm.checkCollision.length).toBe(0)
      sprite = new Sprite
      cm.observe(sprite)
      expect(cm.checkCollision.length).toBe(1)
      cm.observe(sprite)
      expect(cm.checkCollision.length).toBe(1)
    it "unObserve Function removes sprite from checkCollision Array",->
      expect(cm.checkCollision.length).toBe(0)
      sprite = new Sprite
      cm.observe(sprite)
      expect(cm.checkCollision.length).toBe(1)
      cm.unObserve(sprite)
      expect(cm.checkCollision.length).toBe(0)
  ###
  describe 'Collisions',->
    it "works",->
      s1 = new Square(x:10,y:0,width:10)
      s2 = new Square(x:0,y:0,width:20)
      #cm.runCollisionDetection(s1)
      expect(cm.detectCollisions(s1,s2)).toBe(true)
  ###
