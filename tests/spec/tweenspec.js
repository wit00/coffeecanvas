(function() {

  describe('Tween', function() {
    var tween;
    tween = null;
    beforeEach(function() {
      var canvas;
      canvas = document.createElement('canvas');
      canvas.width = 10;
      canvas.height = 10;
      canvas.id = "myCanvas";
      document.body.appendChild(canvas);
      return tween = new Tween();
    });
    describe('Constructor', function() {
      it('Tween is defined', function() {
        return expect(tween).toBeDefined();
      });
      it('attribute is defined and default is x', function() {
        expect(tween.attribute).toBeDefined();
        return expect(tween.attribute).toBe('x');
      });
      it('easeClass is defined and default is None.easeNone', function() {
        expect(tween.easeClass).toBeDefined();
        return expect(tween.easeClass).toBe(None.easeNone);
      });
      it('from is defined and default is 0', function() {
        expect(tween.from).toBeDefined();
        return expect(tween.from).toBe(0);
      });
      it('to is defined and default is 100', function() {
        expect(tween.to).toBeDefined();
        return expect(tween.to).toBe(100);
      });
      it('duration is defined and default is 2000 milleseconds', function() {
        expect(tween.duration).toBeDefined();
        return expect(tween.duration).toBe(2000);
      });
      it('yoyo is defined and default is false', function() {
        expect(tween.yoyo).toBeDefined();
        return expect(tween.yoyo).toBe(false);
      });
      it('elapsed is defined and default is 0', function() {
        expect(tween.elapsed).toBeDefined();
        return expect(tween.elapsed).toBe(0);
      });
      return it('stop is defined and default is tween.duration', function() {
        expect(tween.stop).toBeDefined();
        return expect(tween.stop).toBe(tween.duration);
      });
    });
    return describe('Ease Function', function() {
      it('If tween.elapsed is greater than tween.stop, the tween returns delete.', function() {
        var testTween;
        testTween = new Tween({
          stop: 10
        });
        return expect(testTween.ease(20)).toBe('delete');
      });
      return it('If tween.elapsed is less than tween.stop, the tween returns a value.', function() {
        var testTween;
        testTween = new Tween({
          stop: 10
        });
        return expect(testTween.ease(2)).toBeDefined();
      });
    });
  });

}).call(this);
