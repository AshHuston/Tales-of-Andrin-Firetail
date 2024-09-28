depth = -100;

if drawSelector && hovering >=0 && hovering < array_length(combatants) && step == "Select targets"{
	draw_sprite(spr_targetIndicator, -1, combatants[hovering].x, combatants[hovering].y-25);
}

if drawSelector && step == "Select targets" && targets[0] == "all"{
	for (var i=0; i<array_length(combatants); i++){
		draw_sprite(spr_targetIndicator, -1, combatants[i].x, combatants[i].y-25);
	}
}

if drawSelector && step == "Select targets" && targets[0] == "all enemies"{
	for (var i=0; i<array_length(combatants); i++){
		if object_get_parent(combatants[i].object_index) == obj_enemy{
			draw_sprite(spr_targetIndicator, -1, combatants[i].x, combatants[i].y-25);
		}
	}
}




// ----------------------------------------------------------------  DRAW COMBAT LOGS  ------------------------------------------------------------------
// Need to make them work with colored chunks
function draw_text_multicolor(combatLog, logX, logY, alpha){
	if typeof(combatLog) == "string"{
		var defaultColor = c_white
		draw_text_color(logX, logY, combatLog, defaultColor, defaultColor, defaultColor, defaultColor, alpha)
	}else if typeof(combatLog) == "struct"{
		draw_text_color(logX, logY, combatLog.text, combatLog.color, combatLog.color, combatLog.color, combatLog.color, alpha)
	}else if typeof(combatLog) == "array"{
		
		var logTextWidth = 0
		var chunkSpacing = 2
		for(var i=0; i<array_length(combatLog); i++){
			var xCoord = logX + logTextWidth
			draw_text_color(xCoord, logY, combatLog[i].text, combatLog[i].color, combatLog[i].color, combatLog[i].color, combatLog[i].color, alpha)
			logTextWidth += string_width(combatLog[i].text)+chunkSpacing
		}
	}
}
var cam = camera_get_active()
var popUpLogX = camera_get_view_x(cam) + (camera_get_view_width(cam)/2) - 40 //@TODO Arbitrary for now. Will change when organizing the combat uis
var popUpLogY = camera_get_view_y(cam) + (camera_get_view_height(cam)/2)
var logX = camera_get_view_x(cam) + 15 //@TODO Arbitrary for now. Will change when organizing the combat uis
var logY = camera_get_view_y(cam) + 15
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
	draw_text_multicolor(combatLogEntriesOnDisplay[i].text, popUpLogX, popUpLogY+(logEntrySpacing*i), combatLogEntriesOnDisplay[i].alpha)
}

for (var i=0; i<array_length(combatLogEntries); i++){
	var logEntrySpacing = 10
	draw_text_multicolor(combatLogEntries[i].text, logX, logY+(logEntrySpacing*i), 1)
}