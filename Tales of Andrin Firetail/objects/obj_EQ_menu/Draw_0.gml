for (var i = 0; i<numOfSlots; i++){ 
	var frame = 0
	var slotX = (slot_spacing*slot_coordinates[i,0]) + baseX// + random(range*slot_spacing) - random(range*slot_spacing)
	var slotY = (slot_spacing*slot_coordinates[i,1]) + baseY// + random(range*slot_spacing) - random(range*slot_spacing)
	if i = hoveredSlot{frame = 1}
	draw_sprite(spr_queen_slot, frame, slotX, slotY)	
}

draw_text_ext_color(5,5,string(hoveredCoords),1,10000, c_white, c_white, c_white, c_white, 1)
//draw_text_ext_color(5,5,string(range),1,10000, c_white, c_white, c_white, c_white, 1)