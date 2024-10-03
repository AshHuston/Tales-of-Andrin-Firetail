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
			if hovering >=0 && hovering < array_length(combatants){
				draw_sprite(spr_targetIndicator, -1, combatants[hovering].x, combatants[hovering].y-25);
			}
	}
}

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

