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

#region Dials
var scalePixels = 30				//@DIAL
var itemSpacing = scalePixels*1.3	//@DIAL
var itemXbuff = 0					//@DIAL
var itemYbuff = 0					//@DIAL
var barWidth = 40					//@DIAL
var characterAnchors = [
	anchor,//[0,0],
	[0,0],
	[0,0],
	[0,0],
]
#endregion


#region Display loot
for (var i=0; i<array_length(loot); i++) {
	if loot[i].qty > 0 {
		continue // @TESTING 
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

#region PC exp
/*
var thisCharStuff = {
		name : partyMemberIDs[i].name,
		characterID : partyMemberIDs[i],
		startExp : partyMemberIDs[i].totalExp - global.EXP_SCALE[partyMemberIDs[i].level],
		endExp: 0, //Edits in a few lines.
		currentLevel: partyMemberIDs[i].level,
	}
*/

for (var i=0; i<array_length(characterDisplayVals); i++) { 
	//EXP bar
	var barHeight = sprite_get_height(spr_lifeBarOutline)
	var barXScale = barWidth/sprite_get_width(spr_lifeBarOutline)
	var barYScale = barHeight/sprite_get_height(spr_lifeBarOutline)
	var maxFill = characterDisplayVals[i].expForLevelup
	var barX = characterAnchors[i][X]
	var barY = characterAnchors[i][Y]
	draw_sprite_ext(spr_lifeBarOutline, 0, barX, barY, barXScale, barYScale, 0, c_white, 1)
		
	//Add fill
	var filledWidth = barWidth-2
	var fillPercent = characterDisplayVals[i].startExp/maxFill
	var fillWidth = fillPercent*filledWidth
	var fillXScale = fillWidth/sprite_get_width(spr_lifeBarFiller)
	draw_sprite_ext(spr_lifeBarFiller, 0, barX+1, barY+1, fillXScale, barYScale, 0, c_aqua, 1)
	
	var fillSpeed = 0.5 //@DIAL The way is cuurently is, its gonna slow down a lot as levels get higher. So maybe it should work differntly.
	if characterDisplayVals[i].startExp < characterDisplayVals[i].endExp{ characterDisplayVals[i].startExp += fillSpeed }
	if characterDisplayVals[i].startExp == characterDisplayVals[i].expForLevelup {
		var newLvl = characterDisplayVals[i].currentLevel + 1
		characterDisplayVals[i].startExp = 0
		characterDisplayVals[i].currentLevel = newLvl	
		characterDisplayVals[i].endExp = characterDisplayVals[i].characterID.totalExp - global.EXP_SCALE[newLvl]
		characterDisplayVals[i].expForLevelup = global.EXP_SCALE[newLvl+1] - global.EXP_SCALE[newLvl]
	}
}

#endregion