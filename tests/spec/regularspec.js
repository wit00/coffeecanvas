(function() {

  describe('Regular', function() {
    it('Regular.easeIn moves more slowly in the beginning than in the end', function() {
      return expect(Regular.easeIn(100, 10, 2000, 0) - Regular.easeIn(0, 10, 2000, 0)).toBeLessThan(Regular.easeIn(2000, 10, 2000, 0) - Regular.easeIn(1900, 10, 2000, 0));
    });
    it('Regular.easeOut moves more quickly in the beginning than in the end', function() {
      return expect(Regular.easeOut(100, 10, 2000, 0) - Regular.easeOut(0, 10, 2000, 0)).toBeGreaterThan(Regular.easeOut(2000, 10, 2000, 0) - Regular.easeOut(1900, 10, 2000, 0));
    });
    return it('Regular.easeInOut moves more slowly in the beginning and the end than in the middle', function() {
      return expect(Regular.easeInOut(100, 10, 2000, 0) - Regular.easeInOut(0, 10, 2000, 0)).toBeLessThan(Regular.easeInOut(1050, 10, 2000, 0) - Regular.easeInOut(950, 10, 2000, 0)) && expect(Regular.easeInOut(2000, 10, 2000, 0) - Regular.easeInOut(1900, 10, 2000, 0)).toBeLessThan(Regular.easeInOut(1050, 10, 2000, 0) - Regular.easeInOut(950, 10, 2000, 0));
    });
  });

}).call(this);
