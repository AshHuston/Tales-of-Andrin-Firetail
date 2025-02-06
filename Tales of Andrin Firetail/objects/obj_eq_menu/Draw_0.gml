var hoveringCrystalX = 0
var hoveringCrystalYShadow = 0
var hoveringCrystalY = 0
		
for (var i = 0; i<numOfSlots; i++){ 
	var frame = 0
	var slotX = (slot_spacing*slot_coordinates[i,0]) + baseX// + random(range*slot_spacing) - random(range*slot_spacing)
	var slotY = (slot_spacing*slot_coordinates[i,1]) + baseY// + random(range*slot_spacing) - random(range*slot_spacing)
	if slot_states[i] == FILLED{frame = 2}
	if i = hoveredSlot{frame = 1}
	draw_sprite_ext(spr_slot, frame, slotX, slotY, 1, 1, 0, c_white, slotsAlpha)
	if isHoldingCrystal && i = hoveredSlot{
		hoveringCrystalX = slotX
		hoveringCrystalYShadow = slotY
		hoveringCrystalY = slotY - 6
	}
}
for (var i = 0; i<numOfSlots; i++){
	for (var crystal = 0; crystal<array_length(crystal_inventory); crystal++){ 
		if string(slot_coordinates[i]) == string(crystal_inventory[crystal].coords){
			var crystalX = (slot_spacing*slot_coordinates[i,0]) + baseX
			var crystalY = (slot_spacing*slot_coordinates[i,1]) + baseY
			draw_sprite_ext(crystal_inventory[crystal].sprite, 0, crystalX, crystalY, 1, 1, 0, c_white, 1)
		}
	}
}
if isHoldingCrystal && !in_crystal_list{
	var shakeX = 0
	var shakeY = 0
	if shakeHeldCrystalFrames>0{
		shakeX = random(shakeHeldCrystalFrames/3)
		shakeY = random(shakeHeldCrystalFrames/3)
		shakeHeldCrystalFrames --
	}
	draw_sprite_ext(heldCrystal.sprite, 0, hoveringCrystalX+shakeX, hoveringCrystalYShadow+shakeY, 1, 1, 0, c_black, 0.3)
	draw_sprite_ext(heldCrystal.sprite, 0, hoveringCrystalX+shakeX, hoveringCrystalY+shakeY, 1, 1, 0, c_white, 1)
	}
#region Crystal list
var width = longest_crystal_name_length + (op_borderX*2)
var height = (op_space*num_of_crystals) + (op_borderY*2)
listX += slot_spacing*3 + width/2
listY -= height/2
if numOfSlots<=4{
	listY += slot_spacing*1.5
}else if numOfSlots<=7{
	listY += slot_spacing*3
}else{
	listY += slot_spacing*3
	listX += slot_spacing*2
}

var xScale = width/sprite_get_width(spr_menu)
var yScale = height/sprite_get_height(spr_menu)
draw_sprite_ext(spr_menu, 0, listX, listY, xScale, yScale, 0, c_white, listAlpha)
for (var i=0; i<array_length(crystal_inventory); i++){
	var _c = c_black;
	var fade = .5
	if hoveredCrystal == i && !(listAlpha < slotsAlpha) && !isHoldingCrystal {fade = 0}
	if string(crystal_inventory[i].coords) != string(noCrystal.coords){_c = c_ltgray}
	draw_text_color(listX+op_borderX, listY+op_borderY + op_space*i, crystal_inventory[i].name, _c, _c, _c, _c, listAlpha-fade);	
	if isHoldingCrystal{
		if isHoldingCrystal && in_crystal_list{
		draw_sprite_ext(heldCrystal.sprite, 0, listX+(width/2), listY+(height/2), 1, 1, 0, c_white, 1)
		}
	}
}
if in_crystal_list && !isHoldingCrystal{
	var previewCrystalX = listX + (width/2) + 75//Arbitrary for testing @TODO
	var previewCrystalY = listY + 10		//Arbitrary for testing
	var previewCrystalScaleY = 1.5			//Arbitrary for testing
	var previewCrystalScaleX = 1.5			//Arbitrary for testing
	draw_sprite_ext(crystal_inventory[hoveredCrystal].sprite, 0, previewCrystalX, previewCrystalY, previewCrystalScaleX, previewCrystalScaleY, 0, c_white, 1)
}
#endregion
//@TESTING Equipped crystals
//draw_text_ext_transformed(50, baseY+150, string(global.EQUIPPED_CRYSTALS), 17, 1200, .25, .25, 0)