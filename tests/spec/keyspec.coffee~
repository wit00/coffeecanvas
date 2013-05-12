describe 'KeyManager', ->
  km = 
  beforeEach ->
    canvas = document.createElement('canvas')
    canvas.width = 10
    canvas.height = 10
    canvas.id = "myCanvas"
    document.body.appendChild(canvas)
    km = new KeyManager
  describe 'Constructor', ->
    it 'KeyManager is defined', ->
      expect(km).toBeDefined()
    it 'Sprites Array is Initialized and Empty', ->
      expect(km.sprites).toBeDefined()
      expect(km.sprites.length).toBe(0)
  describe 'Observe Function', ->
    it 'Observe Function adds sprites to Sprites Array',->
      expect(km.sprites.length).toBe(0)
      km.observe(new Sprite)
      expect(km.sprites.length).toBe(1)
