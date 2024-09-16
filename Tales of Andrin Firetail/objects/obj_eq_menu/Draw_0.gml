for (var i = 0; i<numOfSlots; i++){ 
	var frame = 0
	var slotX = (slot_spacing*slot_coordinates[i,0]) + baseX// + random(range*slot_spacing) - random(range*slot_spacing)
	var slotY = (slot_spacing*slot_coordinates[i,1]) + baseY// + random(range*slot_spacing) - random(range*slot_spacing)
	if i = hoveredSlot{frame = 1}
	draw_sprite_ext(spr_slot, frame, slotX, slotY, 1, 1, 0, c_white, slotsAlpha)	
}

draw_text_ext_color(5,5,string(hoveredCoords),1,10000, c_white, c_white, c_white, c_white, 1)
//draw_text_ext_color(5,5,string(range),1,10000, c_white, c_white, c_white, c_white, 1)

//testDisplay
//if in_crystal_list{draw_text_ext_color(100,100,"In crystal list",1,10000, c_white, c_white, c_white, c_white, 1)}

// Crystal list
var width = 75
var xScale = width/sprite_get_width(spr_menu)
var height = 150
var yScale = height/sprite_get_height(spr_menu)

draw_sprite_ext(spr_menu, 0, 200, baseY, xScale, yScale, 0, c_white, listAlpha)