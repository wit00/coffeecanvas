(function() {

  describe('Game Loop', function() {
    return describe('Constructor', function() {
      return it('Game Loop is defined', function() {
        var gl;
        gl = new GameLoop();
        expect(gl).toBeDefined();
        return console.log(gl.animationFrame);
      });
    });
  });

}).call(this);
