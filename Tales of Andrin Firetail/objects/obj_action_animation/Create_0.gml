height = target.sprite_height//*0.8
width = target.sprite_width//*0.8

scale = height/sprite_height
if height < width { scale = width/sprite_width }  

image_yscale = scale
image_xscale = scale