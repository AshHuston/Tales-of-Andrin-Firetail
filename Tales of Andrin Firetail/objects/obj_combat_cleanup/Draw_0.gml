#region Dials
var scalePixels = 30				//@DIAL
var itemSpacing = scalePixels*1.3	//@DIAL
var itemXbuff = 0					//@DIAL
		var itemYbuff = 0			//@DIAL
#endregion

#region center cam anchor setup
var camX = camera_get_view_x(cam)
var camY = camera_get_view_y(cam)
var camWidth = camera_get_view_width(cam)
var camHeight = camera_get_view_height(cam)
var anchor = [
	camX + (camWidth/2),
	camY + (camHeight/2)
	]
#endregion

#region Display loot
for (var i=0; i<array_length(loot); i++) {
	if loot[i].qty > 0 {
		var itemX = anchor[X] + itemXbuff + (itemSpacing*i) 
		var itemY = anchor[Y] + itemYbuff
		var xScale = scalePixels/sprite_get_width(loot[i].sprite)
		var yScale = scalePixels/sprite_get_height(loot[i].sprite)
		var qtyString = "x"+string(loot[i].qty)
		var qtyCoords = [
			itemX - (scalePixels/2),
			itemY + (scalePixels/2)
		]
		draw_sprite_ext(loot[i].sprite, image_index, itemX, itemY, xScale, yScale, 0, c_white, 1)
		draw_text(qtyCoords[X], qtyCoords[Y], qtyString)
	}
}
#endregion