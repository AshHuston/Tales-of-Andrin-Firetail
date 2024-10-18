depth = -100;
combatLogExtraLines = 0
addExtraLine = false
longestTextWidth = 0

if step == "Select targets" && drawSelector{
	switch(targets[0]){
		case "all":
			for (var i=0; i<array_length(combatants); i++){
				draw_sprite(spr_targetIndicator, -1, combatants[i].x, combatants[i].y-25);
			}
		break;
	
		case "all enemies":
			for (var i=0; i<array_length(combatants); i++){
				if object_get_parent(combatants[i].object_index) == obj_enemy{
					draw_sprite(spr_targetIndicator, -1, combatants[i].x, combatants[i].y-25);
				}
			}
		break;
		
		default:
			if hovering >=0 && hovering < array_length(combatants) && combatants[hovering].isConscious{
				draw_sprite(spr_targetIndicator, -1, combatants[hovering].x, combatants[hovering].y-25);
			}
	}
}

#region Combat Logs
// ----------------------------------------------------------------  DRAW COMBAT LOGS  ------------------------------------------------------------------
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

var cam = camera_get_active()

// Popup logs
var popUpLogScreenBorder = 22
var popUpLogX = camera_get_view_x(cam) + popUpLogScreenBorder*0.8
var popUpLogY = camera_get_view_y(cam) + (camera_get_view_height(cam) - popUpLogScreenBorder)

for (var i=0; i<array_length(combatLogEntriesOnDisplay); i++){
	if typeof(combatLogEntriesOnDisplay[i]) == "array"{show_debug_message(combatLogEntriesOnDisplay[i])}
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
#endregion

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

// Loop through the characters and get their bar stats
var charStats = []
for(var i=0; i<array_length(combatants); i++){
	if object_get_parent(combatants[i].object_index) != obj_enemy{
		var stats = {
			name: combatants[i].combatName, 
			maxHp: combatants[i].baseHp, 
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
var boxXScale = boxWidth/sprite_get_width(spr_testCombatStatBackground)
var boxYScale = boxHeight/sprite_get_height(spr_testCombatStatBackground)
for(var i=0; i<array_length(charStats); i++){
	charStats[i].currentHp = clamp(charStats[i].currentHp, 0, charStats[i].maxHp)
	if fadingHP[i] == 0{array_set(fadingHP, i, charStats[i].currentHp)}
	if fadingSecondStat[i] == 0{array_set(fadingSecondStat, i, charStats[i].currentOtherBar)}
	
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
	var secondBarY = barY+(nameYbuffer*2)+string_height("HP1234567890/")+2//spacing
	//Text
	var barTextY = secondBarY - 1 - string_height("HP1234567890/") //Just using each character that could be in the string to assure corect height.
	var barText = string(charStats[i].currentOtherBar) + "/" + string(charStats[i].maxOtherBar)+" "+charStats[i].otherBar
	draw_text_color(barX, barTextY, barText, c_white, c_white, c_white, c_white, 1)
	
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
}


#endregion
#endregion