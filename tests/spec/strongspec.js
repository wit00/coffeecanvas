(function() {

  describe('Strong', function() {
    it('Strong.easeIn moves more slowly in the beginning than in the end', function() {
      return expect(Strong.easeIn(100, 10, 2000, 0) - Strong.easeIn(0, 10, 2000, 0)).toBeLessThan(Strong.easeIn(2000, 10, 2000, 0) - Strong.easeIn(1900, 10, 2000, 0));
    });
    it('Strong.easeOut moves more quickly in the beginning than in the end', function() {
      return expect(Strong.easeOut(100, 10, 2000, 0) - Strong.easeOut(0, 10, 2000, 0)).toBeGreaterThan(Strong.easeOut(2000, 10, 2000, 0) - Strong.easeOut(1900, 10, 2000, 0));
    });
    it('Strong.easeInOut moves more slowly in the beginning and the end than in the middle', function() {
      return expect(Strong.easeInOut(100, 10, 2000, 0) - Strong.easeInOut(0, 10, 2000, 0)).toBeLessThan(Strong.easeInOut(1050, 10, 2000, 0) - Strong.easeInOut(950, 10, 2000, 0)) && expect(Strong.easeInOut(2000, 10, 2000, 0) - Strong.easeInOut(1900, 10, 2000, 0)).toBeLessThan(Strong.easeInOut(1050, 10, 2000, 0) - Strong.easeInOut(950, 10, 2000, 0));
    });
    it('The Strong.easeIn effect is greater than the Regular.easeIn effect', function() {
      return expect(Strong.easeIn(100, 10, 2000, 0) - Strong.easeIn(0, 10, 2000, 0)).toBeLessThan(Regular.easeIn(100, 10, 2000, 0) - Regular.easeIn(0, 10, 2000, 0));
    });
    it('The Strong.easeOut effect is greater than the Regular.easeOut effect', function() {
      return expect(Strong.easeOut(2000, 10, 2000, 0) - Strong.easeOut(1900, 10, 2000, 0)).toBeLessThan(Regular.easeOut(2000, 10, 2000, 0) - Regular.easeOut(1900, 10, 2000, 0));
    });
    return it('The Strong.easeInOut effect is greater than the Regular.easeInOut effect', function() {
      return expect(Strong.easeInOut(100, 10, 2000, 0) - Strong.easeInOut(0, 10, 2000, 0)).toBeLessThan(Regular.easeInOut(100, 10, 2000, 0) - Regular.easeInOut(0, 10, 2000, 0)) && expect(Strong.easeInOut(2000, 10, 2000, 0) - Strong.easeInOut(1900, 10, 2000, 0)).toBeLessThan(Regular.easeInOut(2000, 10, 2000, 0) - Regular.easeInOut(1900, 10, 2000, 0));
    });
  });

}).call(this);
