describe 'Elastic', ->
  it 'Elastic.easeIn effect will move back and bounce at the beginning. This results in a very small overall forward movement at the beginning of the tween.', ->
    expect(Bounce.easeIn(100,100,1000,0)-Bounce.easeIn(0,100,1000,0)).toBeLessThan(2)
  it 'Elastic.easeOut effect will move past the end point and bounce at the end. This results in a very small overall forward movement at the end of the tween.', ->
    expect(Bounce.easeIn(2000,100,1000,0)-Bounce.easeIn(1900,100,1000,0)).toBeLessThan(2)
    
  
