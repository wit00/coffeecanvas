(function() {

  describe('KeyManager', function() {
    var km;
    km = beforeEach(function() {
      var canvas;
      canvas = document.createElement('canvas');
      canvas.width = 10;
      canvas.height = 10;
      canvas.id = "myCanvas";
      document.body.appendChild(canvas);
      return km = new KeyManager;
    });
    describe('Constructor', function() {
      it('KeyManager is defined', function() {
        return expect(km).toBeDefined();
      });
      return it('Sprites Array is Initialized and Empty', function() {
        expect(km.sprites).toBeDefined();
        return expect(km.sprites.length).toBe(0);
      });
    });
    return describe('Observe Function', function() {
      return it('Observe Function adds sprites to Sprites Array', function() {
        expect(km.sprites.length).toBe(0);
        km.observe(new Sprite);
        return expect(km.sprites.length).toBe(1);
      });
    });
  });

}).call(this);
