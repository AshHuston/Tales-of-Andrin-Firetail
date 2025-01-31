#region Character huds
// Define coords for cells
var boxWidth = 75
var boxHeight = 60
var hudCellsXOffset = 18
var hudCellsYOffset = camera_get_view_height(cam)/4
var hudCellsXAnchor = camera_get_view_x(cam) + hudCellsXOffset
var hudCellsYAnchor = camera_get_view_y(cam) + hudCellsYOffset
var hudCellCoords = [
	[hudCellsXAnchor,
	hudCellsYAnchor],
	[hudCellsXAnchor,
	hudCellsYAnchor + boxHeight*1.25], // All these will need to be manually offset, maybe changed based on party size.
	[hudCellsXAnchor,
	hudCellsYAnchor + boxHeight*2.50],
	[hudCellsXAnchor,
	hudCellsYAnchor + boxHeight*3.75]
]
var hoverArrowOffsetY = -15
var hoverArrowOffsetX = round(boxWidth/2)
var toneDown = 3
if shakeSelectorFrames>0{
	var shakeY = random_range(-shakeSelectorFrames, shakeSelectorFrames)/toneDown
	var shakeX = random_range(-shakeSelectorFrames, shakeSelectorFrames)/toneDown
	hoverArrowOffsetY += shakeY
	hoverArrowOffsetX += shakeX
	shakeSelectorFrames --
}

// Loop through the characters and get their bar stats
var charStats = []
for(var i=0; i<array_length(party); i++){
	if party[i] != 0{
		var stats = {
			name: party[i].name, 
			maxHp: party[i].maxHp, 
			currentHp: displayVals[i].displayHp, 
			otherBar: party[i].secondaryDisplayBar, 
			maxOtherBar: party[i].secondaryDisplayBarMax, 
			currentOtherBar: displayVals[i].displayOtherBar
			}
		array_push(charStats, stats)
	}
}

#region Party info
var testX = hudCellCoords[0][0]
var testY = hudCellCoords[0][1]
var boxXScale = boxWidth/sprite_get_width(spr_testCombatStatBackground)
var boxYScale = boxHeight/sprite_get_height(spr_testCombatStatBackground)
for(var i=0; i<array_length(charStats); i++){
	charStats[i].currentHp = clamp(charStats[i].currentHp, 0, charStats[i].maxHp)
	
	//Box
	var boxX = hudCellCoords[i][0]
	var boxY = hudCellCoords[i][1]
	draw_sprite_ext(spr_testCombatStatBackground, 0, boxX, boxY, boxXScale, boxYScale, 0, c_white, 1)

	//Name
	var nameXbuffer = 3
	var nameYbuffer = 3
	var nameX = boxX + nameXbuffer
	var nameY = boxY + nameYbuffer
	draw_text_color(nameX, nameY, charStats[i].name, c_white, c_white, c_white, c_white, 1)

	//HP bar
	var barWidth = boxWidth - (nameXbuffer*2)
	var barHeight = sprite_get_height(spr_lifeBarOutline)
	var barXScale = barWidth/sprite_get_width(spr_lifeBarOutline)
	var barYScale = barHeight/sprite_get_height(spr_lifeBarOutline)
	var maxFill = charStats[i].maxHp
	var barX = nameX
	var barY = nameY+nameYbuffer+string_height(charStats[i].name) + string_height("HP1234567890/")
	draw_sprite_ext(spr_lifeBarOutline, 0, barX, barY, barXScale, barYScale, 0, c_white, 1)
	var hpTextY = barY - 1 - string_height("HP1234567890/") //Just using each character that could be in the string to assure corect height.
	var hpText = string(charStats[i].currentHp) + "/" + string(charStats[i].maxHp)+" HP" 
	draw_text_color(barX, hpTextY, hpText, c_white, c_white, c_white, c_white, 1)
		
	//Add red health
	var filledWidth = barWidth-2
	var fillPercent = charStats[i].currentHp/charStats[i].maxHp
	var fillWidth = fillPercent*filledWidth
	var fillXScale = fillWidth/sprite_get_height(spr_lifeBarFiller)
	draw_sprite_ext(spr_lifeBarFiller, 0, barX+1, barY+1, fillXScale, barYScale, 0, c_red, 1)

	//other bar
	var secondStatColor = c_white
	switch (string_lower(charStats[i].otherBar)){
		case "mp": secondStatColor = c_teal break;
		case "energy": secondStatColor = #FFD700 break;
	}
	var secondBarWidth = boxWidth - (nameXbuffer*2)
	var secondBarHeight = sprite_get_height(spr_lifeBarOutline)
	var secondBarXScale = secondBarWidth/sprite_get_width(spr_lifeBarOutline)
	var secondBarYScale = secondBarHeight/sprite_get_height(spr_lifeBarOutline)
	var otherMaxFill = charStats[i].maxOtherBar
	var secondBarX = nameX
	var secondBarY = barY+(nameYbuffer*2)+string_height("HP1234567890/")+2//spacing
	//Text
	var barTextY = secondBarY - 1 - string_height("HP1234567890/") //Just using each character that could be in the string to assure corect height.
	var barText = string(charStats[i].currentOtherBar) + "/" + string(charStats[i].maxOtherBar)+" "+charStats[i].otherBar
	draw_text_color(barX, barTextY, barText, c_white, c_white, c_white, c_white, 1)
	
	draw_sprite_ext(spr_lifeBarOutline, 0, secondBarX, secondBarY, secondBarXScale, secondBarYScale, 0, c_white, 1)
	
	//other stat
	var secondFilledWidth = barWidth-2
	var secondFillPercent = charStats[i].currentOtherBar/charStats[i].maxOtherBar
	var secondFillWidth = secondFillPercent*secondFilledWidth
	var secondFillXScale = secondFillWidth/sprite_get_height(spr_lifeBarFiller)
	draw_sprite_ext(spr_lifeBarFiller, 0, secondBarX+1, secondBarY+1, secondFillXScale, secondBarYScale, 0, secondStatColor, 1)

	// Hover arrow 
	if i == selectionIndex && isInSelectionMode{
		draw_sprite_ext(spr_targetIndicator, 0, boxX+hoverArrowOffsetX, boxY+hoverArrowOffsetY, 1, 1, 0, c_white, 1)
	}
}
#endregion
#endregion
