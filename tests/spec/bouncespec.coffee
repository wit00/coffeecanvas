describe 'Bounce', ->
  it 'Bounce.easeIn effect will move towards the end, back, and again towards the end', ->
    expect(Bounce.easeIn(1,10,2.74,0)-Bounce.easeIn(0,10,2.74,0)).toBeGreaterThan(0)
    expect(Bounce.easeIn(1.5,10,2.75,0)-Bounce.easeIn(0.5,10,2.75,0)).toBeLessThan(Bounce.easeIn(1,10,2.74,0)-Bounce.easeIn(0,10,2.74,0))  
    expect(Bounce.easeIn(2.5,10,2.75,0)-Bounce.easeIn(1.5,10,2.75,0)).toBeGreaterThan(Bounce.easeIn(1.5,10,2.74,0)-Bounce.easeIn(0.5,10,2.74,0))  
  
