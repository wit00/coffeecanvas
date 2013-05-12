describe 'Mixins', ->
  it 'Mixins add functions to sprites', ->
      s = new Sprite
      test =
        moo:()-> console.log "moo"
      include(test,Sprite)
      s.moo() #test would fail if undefined
