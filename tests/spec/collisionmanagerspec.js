(function() {

  describe('CollisionManager', function() {
    var cm;
    cm = beforeEach(function() {
      var canvas;
      canvas = document.createElement('canvas');
      canvas.width = 100;
      canvas.height = 100;
      canvas.id = "myCanvas";
      document.body.appendChild(canvas);
      return cm = new CollisionManager;
    });
    describe('Constructor', function() {
      it('CollisionManager is defined', function() {
        return expect(cm).toBeDefined();
      });
      it('checkCollision Array is Defined and Empty', function() {
        expect(cm.checkCollision).toBeDefined();
        return expect(cm.checkCollision.length).toBe(0);
      });
      return it('collided Array is Defined and Empty', function() {
        expect(cm.collided).toBeDefined();
        return expect(cm.collided.length).toBe(0);
      });
    });
    return describe('Observe Functions', function() {
      it("Observe Function adds sprite to checkCollision Array", function() {
        expect(cm.checkCollision.length).toBe(0);
        cm.observe(new Sprite);
        return expect(cm.checkCollision.length).toBe(1);
      });
      it("Observe Function does not add sprite to checkCollision Array if it is already in checkCollision", function() {
        var sprite;
        expect(cm.checkCollision.length).toBe(0);
        sprite = new Sprite;
        cm.observe(sprite);
        expect(cm.checkCollision.length).toBe(1);
        cm.observe(sprite);
        return expect(cm.checkCollision.length).toBe(1);
      });
      return it("unObserve Function removes sprite from checkCollision Array", function() {
        var sprite;
        expect(cm.checkCollision.length).toBe(0);
        sprite = new Sprite;
        cm.observe(sprite);
        expect(cm.checkCollision.length).toBe(1);
        cm.unObserve(sprite);
        return expect(cm.checkCollision.length).toBe(0);
      });
    });
    /*
      describe 'Collisions',->
        it "works",->
          s1 = new Square(x:10,y:0,width:10)
          s2 = new Square(x:0,y:0,width:20)
          #cm.runCollisionDetection(s1)
          expect(cm.detectCollisions(s1,s2)).toBe(true)
    */
  });

}).call(this);
