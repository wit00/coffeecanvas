describe 'Regular', ->
  it 'Regular.easeIn moves more slowly in the beginning than in the end', ->
    #expect the change in the first 100 milleseconds to be less than the change in the last 100 milleseconds
    expect(Regular.easeIn(100,10,2000,0)-Regular.easeIn(0,10,2000,0)).toBeLessThan(Regular.easeIn(2000,10,2000,0)-Regular.easeIn(1900,10,2000,0))
  it 'Regular.easeOut moves more quickly in the beginning than in the end', ->
    #expect the change in the first 100 milleseconds to be greater than the change in the last 100 milleseconds
    expect(Regular.easeOut(100,10,2000,0)-Regular.easeOut(0,10,2000,0)).toBeGreaterThan(Regular.easeOut(2000,10,2000,0)-Regular.easeOut(1900,10,2000,0))
  it 'Regular.easeInOut moves more slowly in the beginning and the end than in the middle',->
    #expect the change in the middle 100 milleseconds to be greater than the change in the first 100 milleseconds and the last 100 milleseconds
    expect(Regular.easeInOut(100,10,2000,0)-Regular.easeInOut(0,10,2000,0)).toBeLessThan(Regular.easeInOut(1050,10,2000,0)-Regular.easeInOut(950,10,2000,0)) and expect(Regular.easeInOut(2000,10,2000,0)-Regular.easeInOut(1900,10,2000,0)).toBeLessThan(Regular.easeInOut(1050,10,2000,0)-Regular.easeInOut(950,10,2000,0))
