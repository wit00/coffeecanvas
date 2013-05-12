#The matrix class creates the transformation matrix that is applied to the canvas every time a 
#sprite is drawn. I am using it rather than the HTML5 inbuilt transformations because it allows custom 
#transformations by the user. 
class Matrix
 constructor: (@a=1, @b=0, @c=0, @d=1, @e=0, @f=0) ->
    @xScale=1
    @yScale=1
    @xSkew=0
    @ySkew=0
    @xTranslation=0
    @yTranslation=0
    @rotation = 0
  
  makeTransformationMatrix: () ->
    @a = Math.cos(@rotation)*@xScale-Math.sin(@rotation)*@xSkew 
    @b = Math.sin(@rotation)*@xScale + Math.cos(@rotation)*@xSkew
    @c = Math.cos(@rotation)*@ySkew - Math.sin(@rotation)*@yScale
    @d = Math.sin(@rotation)*@ySkew + Math.cos(@rotation)*@yScale
    @e = @xTranslation
    @f = @yTranslation
    
    #ToDo: test if this is faster or slower than running the inbuilt HTML5 rotations, scalings, etc.
