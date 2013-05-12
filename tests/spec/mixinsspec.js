(function() {

  describe('Mixins', function() {
    return it('Mixins add functions to sprites', function() {
      var s, test;
      s = new Sprite;
      test = {
        moo: function() {
          return console.log("moo");
        }
      };
      include(test, Sprite);
      return s.moo();
    });
  });

}).call(this);
