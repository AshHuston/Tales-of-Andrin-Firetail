depth = -100;
var cam = camera_get_active()
combatLogExtraLines = 0
addExtraLine = false
longestTextWidth = 0

#region Target selection
function drawArrows(allTargets, indicatorAlpha = 1){
	function drawArrowOver(target, indicatorAlpha){
		draw_sprite_ext(spr_targetIndicator, -1, target.x, target.y-25, 0.5, 0.5, 0, c_white, indicatorAlpha);	
	}
	
	switch(allTargets){
		case "all":
			for (var i=0; i<array_length(combatants); i++){
				drawArrowOver(combatants[i], indicatorAlpha)
			}
		break;
	
		case "all enemies":
			for (var i=0; i<array_length(combatants); i++){
				if object_get_parent(combatants[i].object_index) == obj_enemy{
					drawArrowOver(combatants[i], indicatorAlpha)
				}
			}
		break;
		
		case "hovered":
			if hovering >=0 && hovering < array_length(combatants) && combatants[hovering].isConscious{
				drawArrowOver(combatants[hovering], indicatorAlpha)
			}
		break;
			
		default:
			drawArrowOver(allTargets, indicatorAlpha)
	}

}

if step == "Select targets" && drawSelector {
	var non_hovereds = ["all enemies", "all"]
	if array_contains(non_hovereds, targets[0]) { drawArrows(targets[0]) }
	else { drawArrows("hovered") }
}
#endregion

#region Hovered action (1/2) All but the bar-indicator
if hoveredAction.name != "none" && hoveredAction.name != "<--Back"{
	#region Gather data
	function getRightCostIcon(action){
		if !variable_struct_exists(action, "cost_type"){ return spr_wall }
		switch (string_lower(action.cost_type)){
			case "mp": return spr_mana_icon;
			case "energy": return spr_energy_icon
		}
	}
	
	function getDmgRange(action){
		var displayThis = false
		if action.actionType == "spell"{ if action.spellType == "attack"{ displayThis = true } }
		if action.actionType == "attack"{ displayThis  = true}
		
		if displayThis{
			return string(action.min_dmg)+"-"+string(action.min_dmg)
		}else{ return "" }
	}
	
	var aspectPadding = 3
	var lines = [
		{icon: spr_accuracy_icon, value: string(hoveredAction.hit_chance)+"%"},
		{icon: spr_dmg_icon, value: getDmgRange(hoveredAction)}
		]
	if getRightCostIcon(hoveredAction) != spr_wall{
		array_push(lines, {icon: getRightCostIcon(hoveredAction), value: hoveredAction.cost_value})
	}
	#endregion
	
	#region Box
	var hovBoxWidth = aspectPadding*3 + string_width("W")*7
	var hovBoxHeight = aspectPadding + (aspectPadding+string_height("|"))*array_length(lines)
	draw_sprite_ext(spr_menu, image_index, actionStatsOrigin[0], actionStatsOrigin[1], hovBoxWidth/sprite_get_width(spr_menu), hovBoxHeight/sprite_get_height(spr_menu), 0, c_white, 1)
	#endregion
	
	#region Icons/text
	
	#endregion
	
	#region Valid Targets
	var validTargets = hoveredAction.targetID
	if validTargets == ""{ //@TODO Sets to an enemy. Techniallywring because it could be a party-only effect.
		for (var i=0; i<array_length(combatants); i++){
			if object_get_parent(combatants[i].object_index) == obj_enemy{
				validTargets = combatants[i]
			}
		}
	}
	drawArrows(validTargets, 0.5)
	#endregion
}
#endregion

#region Character huds
// Define coords for cells
var boxWidth = 65
var boxHeightDefault = 27
var boxSpacing = 3
var hudCellsXOffset = 5
var hudCellsYOffset = 3
var hudCellsXAnchor = camera_get_view_x(cam) + hudCellsXOffset
var hudCellsYAnchor = camera_get_view_y(cam) + hudCellsYOffset
var hudCellCoords = [
	[hudCellsXAnchor,
	hudCellsYAnchor],
	[hudCellsXAnchor + (boxWidth+boxSpacing),
	hudCellsYAnchor],
	[hudCellsXAnchor + (boxWidth+boxSpacing)*2,
	hudCellsYAnchor],
	[hudCellsXAnchor + (boxWidth+boxSpacing)*3,
	hudCellsYAnchor]
]

// Loop through the characters and get their bar stats
var charStats = []
for(var i=0; i<array_length(combatants); i++){
	if object_get_parent(combatants[i].object_index) != obj_enemy{
		var stats = {
			name: combatants[i].combatName, 
			maxHp: combatants[i].baseStats.hp, 
			currentHp: combatants[i].currentHp, 
			otherBar: combatants[i].secondaryDisplayBar, 
			maxOtherBar: combatants[i].secondaryDisplayBarMax, 
			currentOtherBar: combatants[i].secondaryDisplayBarCurrent
			}
		array_push(charStats, stats)
	}
}

#region Party info
var testX = hudCellCoords[0][0]
var testY = hudCellCoords[0][1]
for(var i=0; i<array_length(charStats); i++){
	var isActive = charStats[i].name == activeCombatant.combatName
	var boxHeight = 0
	if isActive{ boxHeight = boxHeightDefault + 20}else{boxHeight = boxHeightDefault}
	var boxXScale = boxWidth/sprite_get_width(spr_testCombatStatBackground)
	var boxYScale = boxHeight/sprite_get_height(spr_testCombatStatBackground)
	
	charStats[i].currentHp = clamp(charStats[i].currentHp, 0, charStats[i].maxHp)
	if fadingHP[i] == 0{array_set(fadingHP, i, charStats[i].currentHp)}
	if fadingSecondStat[i] == 0{array_set(fadingSecondStat, i, charStats[i].currentOtherBar)}
	
	//Box
	var boxX = hudCellCoords[i][0]
	var boxY = hudCellCoords[i][1]
	var col = c_white
	
	if isActive { 
		col = c_yellow
		}
	draw_sprite_ext(spr_testCombatStatBackground, 0, boxX, boxY, boxXScale, boxYScale, 0, col, 1)

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
	var barY = nameY + nameYbuffer + string_height(charStats[i].name)
	if isActive{ barY += string_height("HP1234567890/")}
	draw_sprite_ext(spr_lifeBarOutline, 0, barX, barY, barXScale, barYScale, 0, c_white, 1)
	var hpTextY = barY - 1 - string_height("HP1234567890/") //Just using each character that could be in the string to assure corect height.
	var hpText = string(charStats[i].currentHp) + "/" + string(charStats[i].maxHp)+" HP" 
	if isActive{draw_text_color(barX, hpTextY, hpText, c_white, c_white, c_white, c_white, 1)}
	
	//Add white health
	var catchupSpd = 0.25 //Must land on every integer. So no 0.3s or 0.7s etc.
	if fadingHP[i] > charStats[i].currentHp{fadingHP[i]-=catchupSpd}
	if fadingHP[i] < charStats[i].currentHp{fadingHP[i]+=catchupSpd}
	var filledWidthFade = barWidth-2
	var fillPercentFade = fadingHP[i]/charStats[i].maxHp
	var fillWidthFade = fillPercentFade*filledWidthFade
	var fillXScaleFade = fillWidthFade/sprite_get_height(spr_lifeBarFiller)
	draw_sprite_ext(spr_lifeBarFiller, 0, barX+1, barY+1, fillXScaleFade, barYScale, 0, c_white, 1)
	
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
	var secondBarY = barY + nameYbuffer + 2
	if isActive {secondBarY+= nameYbuffer + string_height("HP1234567890/")}
	//Text
	var barTextY = secondBarY - 1 - string_height("HP1234567890/") //Just using each character that could be in the string to assure corect height.
	var barText = string(charStats[i].currentOtherBar) + "/" + string(charStats[i].maxOtherBar)+" "+charStats[i].otherBar
	if isActive{draw_text_color(barX, barTextY, barText, c_white, c_white, c_white, c_white, 1)}
	
	if shakeSecondBarFrames>0 && activeCombatant.combatName == charStats[i].name{
		var shakeWeight = 0.4
		secondBarX += (random_range(-shakeSecondBarFrames, shakeSecondBarFrames)*shakeWeight)
		secondBarY += (random_range(-shakeSecondBarFrames, shakeSecondBarFrames)*shakeWeight)
		shakeSecondBarFrames--
	}
	
	draw_sprite_ext(spr_lifeBarOutline, 0, secondBarX, secondBarY, secondBarXScale, secondBarYScale, 0, c_white, 1)
	//Fadestat
	if fadingSecondStat[i] > charStats[i].currentOtherBar{fadingSecondStat[i]-=catchupSpd}
	if fadingSecondStat[i] < charStats[i].currentOtherBar{fadingSecondStat[i]+=catchupSpd}
	var secondFilledWidthFade = barWidth-2
	var secondFillPercentFade = fadingSecondStat[i]/charStats[i].maxOtherBar
	var secondFillWidthFade = secondFillPercentFade*secondFilledWidthFade
	var secondFillXScaleFade = secondFillWidthFade/sprite_get_height(spr_lifeBarFiller)
	draw_sprite_ext(spr_lifeBarFiller, 0, secondBarX+1, secondBarY+1, secondFillXScaleFade, secondBarYScale, 0, c_white, 1)

	//other stat
	var secondFilledWidth = barWidth-2
	var secondFillPercent = charStats[i].currentOtherBar/charStats[i].maxOtherBar
	var secondFillWidth = secondFillPercent*secondFilledWidth
	var secondFillXScale = secondFillWidth/sprite_get_height(spr_lifeBarFiller)
	draw_sprite_ext(spr_lifeBarFiller, 0, secondBarX+1, secondBarY+1, secondFillXScale, secondBarYScale, 0, secondStatColor, 1)

	#region Hovered action (2/2) Cost indicator
	//Many of these variable are copied from above but hey it works.
	try{
		if hoveredAction.name !="none" && variable_struct_exists(hoveredAction, "cost_value"){// && charStats[i].name == activeCombatant.name{
			draw_sprite_ext(spr_lifeBarFiller, 0, secondBarX+1, secondBarY+1, secondFillXScale, secondBarYScale, 0, c_white, blinkAlpha)
			var remainingWidth = charStats[i].currentOtherBar-hoveredAction.cost_value
			//secondFillPercent = (charStats[i].currentOtherBar-remainingWidth)/charStats[i].maxOtherBar
			secondFillPercent = remainingWidth/charStats[i].maxOtherBar
			secondFillWidth = secondFillPercent*secondFilledWidth
			secondFillXScale = secondFillWidth/sprite_get_height(spr_lifeBarFiller)
			draw_sprite_ext(spr_lifeBarFiller, 0, secondBarX+1, secondBarY+1, secondFillXScale, secondBarYScale, 0, secondStatColor, 1)
		}
	}catch(err){print(err)}
	#endregion
}


#endregion
#endregion



#region Combat Logs

function get_full_log_entry_width(logEntry, spacing=2){ /// ====================== USE THIS =================
	var logTextWidth = 0
	for(var i=0; i<array_length(logEntry); i++){
			logTextWidth += string_width(logEntry[i].text)+spacing
		}
		if logTextWidth > longestTextWidth{longestTextWidth = logTextWidth}
	return logTextWidth	
}


function draw_log_entry_multicolor(logEntry, logX, logY, alpha, lineMaxWidth, addFullLogHeightToBackground=false){
	if typeof(logEntry) == "string"{
		var defaultColor = c_white
		draw_text_color(logX, logY, logEntry, defaultColor, defaultColor, defaultColor, defaultColor, alpha)
	}else if typeof(logEntry) == "struct"{
		draw_text_color(logX, logY, logEntry.text, logEntry.color, logEntry.color, logEntry.color, logEntry.color, alpha)
	}else if typeof(logEntry) == "array"{
		var lineSpacing = string_height(logEntry[0].text) + 2 //Can be adjusted manually for fine tuning.
		var numOfLines = 0
		var logTextWidth = 0
		var entrySpacing = 12
		var wordSpacing = 2
		var lineStartIndex = 0
		addExtraLine = false
		for(var i=0; i<array_length(logEntry); i++){
			var currentLine = []
			array_copy(currentLine, 0, logEntry, lineStartIndex, i-lineStartIndex)
			if get_full_log_entry_width(currentLine, wordSpacing) > lineMaxWidth{
				logTextWidth = 0
				numOfLines++
				lineStartIndex = i
				addExtraLine = true
			}
			var xCoord = logX + logTextWidth
			var yCoord = logY + ((lineSpacing*numOfLines)+(entrySpacing*combatLogExtraLines))
			draw_text_color(xCoord, yCoord, logEntry[i].text, logEntry[i].color, logEntry[i].color, logEntry[i].color, logEntry[i].color, alpha)
			logTextWidth += string_width(logEntry[i].text)+wordSpacing
		}
		if addFullLogHeightToBackground{
			totalLines += numOfLines + 1
		}
	}
}


function get_log_entry_seperate_words(logEntry, delimiters=[" "]){
	var logWordsAndColors = []
	for(var i=0; i<array_length(logEntry); i++){
			var words = string_split_ext(logEntry[i].text, delimiters)
			for(var n=0; n<array_length(words); n++){
				array_push(logWordsAndColors, {text: words[n], color: logEntry[i].color})
			}
		}
	return logWordsAndColors	
}



depth--
// Popup logs
var popUpLogScreenBorder = 30
var popUpLogX = camera_get_view_x(cam) + popUpLogScreenBorder*0.8
var popUpLogY = camera_get_view_y(cam) + (camera_get_view_height(cam) - popUpLogScreenBorder)

for (var i=0; i<array_length(combatLogEntriesOnDisplay); i++){
	//if typeof(combatLogEntriesOnDisplay[i]) == "array"{show_debug_message(combatLogEntriesOnDisplay[i])}
	combatLogEntriesOnDisplay[i].frames--
	var fadeFrames = 15
	if combatLogEntriesOnDisplay[i].frames <= fadeFrames{
		combatLogEntriesOnDisplay[i].alpha -= (1/fadeFrames)
	}
	if combatLogEntriesOnDisplay[i].frames < -60{
		array_delete(combatLogEntriesOnDisplay, i, 1)
		continue
	}
	var logEntrySpacing = 10
	var logText = get_log_entry_seperate_words(combatLogEntriesOnDisplay[i].text)
	draw_log_entry_multicolor(logText, popUpLogX, popUpLogY-(logEntrySpacing*(array_length(combatLogEntriesOnDisplay)-i-1)), combatLogEntriesOnDisplay[i].alpha, 1000)
}

// Full logs
var fullLogtextWidth = 125
var fullLogScreenBorderX = 25
var fullLogScreenBorderY = 15
var fullLogOriginX = camera_get_view_x(cam) + camera_get_view_width(cam) - fullLogtextWidth - fullLogScreenBorderX
var fullLogOriginXClosed = round(fullLogOriginX + fullLogtextWidth*1.5)
var fullLogOriginY = camera_get_view_y(cam) + fullLogScreenBorderY
var goalX = 0
var slideSpeed = 35
if setCurrentToOffScreen{goalX = fullLogOriginXClosed; setCurrentToOffScreen=false}
if hideCombatLog{goalX = fullLogOriginXClosed}
else{goalX = fullLogOriginX}

// Log background
var fullLogPaddingX = 12
var fullLogPaddingY = 9
var backgroundX = currentX - (fullLogPaddingX/2)
var backgroundY = fullLogOriginY - (fullLogPaddingY/2)
var textHeight = string_height("I") + 4 // additional buffer
var bgXScale = ((fullLogPaddingX*2)+(fullLogtextWidth))/sprite_get_width(spr_logBackground)
totalLines += combatLogExtraLines
var bgYScale = ((fullLogPaddingY)+((textHeight)*totalLines))/sprite_get_height(spr_logBackground)
var opacity = 0.4
draw_sprite_ext(spr_logBackground, 0, backgroundX, backgroundY, bgXScale, bgYScale, 0, c_white, opacity)
totalLines = 0

//move the current coords to the goal coords
if currentX != goalX{
	if goalX>currentX{currentX+=slideSpeed}
	else{currentX-=slideSpeed}
	currentX = clamp(currentX, fullLogOriginX, fullLogOriginXClosed)
}
for (var i=0; i<array_length(combatLogEntries); i++){
	if addExtraLine{combatLogExtraLines++}
	var logEntrySpacing = 12
	var logText = get_log_entry_seperate_words(combatLogEntries[i].text)
	draw_log_entry_multicolor(logText, currentX, fullLogOriginY+(logEntrySpacing*i), 1, fullLogtextWidth, true)
}
depth++
#endregion

