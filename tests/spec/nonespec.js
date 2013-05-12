(function() {

  describe('None', function() {
    return it('None.easeNone has no easing effect, so the first half of the tween causes as much change as the last half', function() {
      return expect(None.easeNone(1000, 10, 2000, 0) - None.easeNone(0, 10, 2000, 0)).toBe(None.easeNone(2000, 10, 2000, 0) - None.easeNone(1000, 10, 2000, 0));
    });
  });

}).call(this);
