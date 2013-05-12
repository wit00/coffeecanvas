(function() {

  describe('Scene', function() {
    var scene;
    scene = null;
    beforeEach(function() {
      var canvas;
      canvas = document.createElement('canvas');
      canvas.width = 10;
      canvas.height = 10;
      canvas.id = "myCanvas";
      document.body.appendChild(canvas);
      return scene = new Scene();
    });
    describe('Constructor', function() {
      it('Scene is defined', function() {
        return expect(scene).toBeDefined();
      });
      return it('Sprites array is created in constructor', function() {
        expect(scene.sprites).toBeDefined();
        return scene.sprites.length = 0;
      });
    });
    describe('Add Sprites to the Sprites Array', function() {
      it('Add sprite to Sprites Array', function() {
        var sprite;
        sprite = new Sprite();
        scene.addSprite(sprite);
        return expect(scene.sprites.length).toBe(1);
      });
      it('Add 1 sprite to Sprites Array with addSprites(sprites...)', function() {
        scene.addSprites(new Sprite);
        return expect(scene.sprites.length).toBe(1);
      });
      return it('Add 4 sprites with addSprites(sprites...)', function() {
        scene.addSprites(new Sprite(), new Sprite, new Sprite, new Sprite);
        return expect(scene.sprites.length).toBe(4);
      });
    });
    describe('Update and Draw Functions', function() {
      it('Update function runs with 0 sprites', function() {
        return scene.update();
      });
      it('Draw function runs with 0 sprites', function() {
        return scene.draw();
      });
      it('Update function runs with 1 sprite', function() {
        scene.addSprite(new Sprite());
        return scene.update();
      });
      it('Draw function runs with 1 sprite', function() {
        scene.addSprite(new Sprite());
        return scene.draw();
      });
      it('Update function runs with 3 sprites', function() {
        scene.addSprite(new Sprite());
        scene.addSprite(new Sprite());
        scene.addSprite(new Sprite());
        return scene.update();
      });
      return it('Draw function runs with 3 sprites', function() {
        scene.addSprite(new Sprite());
        scene.addSprite(new Sprite());
        scene.addSprite(new Sprite());
        return scene.draw();
      });
    });
    return describe('Add Children', function() {
      it('Add a Child to a Sprite', function() {
        return scene.makeChild(new Sprite, new Sprite);
      });
      it('Add 5 Children to a Sprite', function() {
        var parent;
        parent = new Sprite;
        scene.makeChild(parent, new Sprite);
        scene.makeChild(parent, new Sprite);
        scene.makeChild(parent, new Sprite);
        scene.makeChild(parent, new Sprite);
        return scene.makeChild(parent, new Sprite);
      });
      return it('Add a Child to a Child Sprite', function() {
        var child, grandchild, parent;
        parent = new Sprite({
          x: 100,
          y: 100
        });
        child = new Sprite({
          x: 0,
          y: 0
        });
        grandchild = new Sprite({
          x: 10,
          y: 10
        });
        scene.makeChild(parent, child);
        expect(child.adjustedX).toBe(100);
        expect(child.adjustedY).toBe(100);
        scene.makeChild(child, grandchild);
        expect(grandchild.adjustedX).toBe(110);
        return expect(grandchild.adjustedY).toBe(110);
      });
    });
  });

}).call(this);
