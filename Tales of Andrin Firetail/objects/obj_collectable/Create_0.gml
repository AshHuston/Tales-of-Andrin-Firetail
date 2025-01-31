itemInfo = {
		name:"none", 
		quantity: 1,
		stackable: true,
		use: show_debug_message("BLANK ITEM"), 
		description:"BLANK ITEM", 
		}
		
width = 16
height = 116
xScale = width/sprite_get_width(sprite_index)
yScale = height/sprite_get_height(sprite_index)
scale = xScale
if yScale < scale {scale = yScale}
image_xscale = scale
image_yscale = scale