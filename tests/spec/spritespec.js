(function() {

  describe('Sprite', function() {
    var sprite;
    sprite = null;
    beforeEach(function() {
      return sprite = new Sprite();
    });
    describe('Constructor', function() {
      it('Sprite is defined', function() {
        return expect(sprite).toBeDefined();
      });
      it('Sprites can set Arguments in the Constructor', function() {
        sprite = new Sprite({
          x: 20
        });
        return expect(sprite.x).toBe(20);
      });
      it('Sprite Arguments are defined', function() {
        return expect(sprite.x && sprite.y && sprite.angularVelocity && sprite.rotation && sprite.width && sprite.subSprites && sprite.lineWidth && sprite.lineCap && sprite.lineJoin && sprite.miterLimit && sprite.events && sprite.receivedEvents && sprite.toDeleteEvents).toBeDefined();
      });
      return it('subSprites Array defined and empty', function() {
        expect(sprite.subSprites).toBeDefined();
        return expect(sprite.subSprites.length).toBe(0);
      });
    });
    return describe('Methods', function() {
      it('Sprites translate', function() {
        sprite.x = 0;
        sprite.y = 0;
        sprite.translate(10, 10);
        expect(sprite.x).toBe(10);
        return expect(sprite.y).toBe(10);
      });
      it('Sprite translates with negative directions', function() {
        sprite.translate(-10, -100);
        expect(sprite.x).toBe(-10);
        return expect(sprite.y).toBe(-100);
      });
      it('Sprite can add animations to its animations array', function() {
        expect(sprite.animations).toBeDefined();
        expect(sprite.animations.length).toBe(0);
        sprite.addAnimation(new Tween);
        return expect(sprite.animations.length).toBe(1);
      });
      it('Sprite can delete animations from its animations array', function() {
        var t;
        expect(sprite.animations).toBeDefined();
        expect(sprite.animations.length).toBe(0);
        t = new Tween;
        sprite.addAnimation(t);
        expect(sprite.animations.length).toBe(1);
        sprite.deleteAnimation(t);
        return expect(sprite.animations.length).toBe(0);
      });
      it('Sprites run events they have registered', function() {
        var e, event;
        event = {
          code: 1,
          action: "keys"
        };
        sprite.events[0] = event;
        expect(sprite.receivedEvents[event.keyCode]).not.toBeDefined();
        e = {
          keyCode: 1,
          type: "keys"
        };
        sprite.receiveEvent(e);
        return expect(sprite.receivedEvents[e.keyCode]).toBe(true);
      });
      it('Sprites do not run events they have not registered', function() {
        var e, event;
        event = {
          code: 1,
          action: "keys"
        };
        sprite.events[0] = event;
        expect(sprite.receivedEvents[event.keyCode]).not.toBeDefined();
        e = {
          keyCode: 2,
          type: "keys"
        };
        sprite.receiveEvent(e);
        return expect(sprite.receivedEvents[e.keyCode]).not.toBeDefined();
      });
      return it('When a sprite runs its events, it deletes any to be deleted animations', function() {
        var event;
        event = {};
        sprite.animations[0] = event;
        sprite.toDeleteEvents.push(event);
        expect(sprite.animations.length).toBe(1);
        sprite.runEvents();
        return expect(sprite.animations.length).toBe(0);
      });
    });
  });

}).call(this);
