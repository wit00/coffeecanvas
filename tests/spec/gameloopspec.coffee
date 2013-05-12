describe 'Game Loop', ->
  describe 'Constructor', ->
    it 'Game Loop is defined', ->
      gl = new GameLoop()
      expect(gl).toBeDefined()
      console.log gl.animationFrame
      
