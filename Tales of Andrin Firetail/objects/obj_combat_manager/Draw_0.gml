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
	
// Draw combat logs
// Need to make them decay
var cam = camera_get_active()
var logX = camera_get_view_x(cam) + (camera_get_view_width(cam)/2)
var logY = camera_get_view_y(cam) + (camera_get_view_height(cam)/2)
for (var i=0; i<array_length(combatLogEntriesOnDisplay); i++){
	var text = combatLogEntriesOnDisplay[i].text
	var color = combatLogEntriesOnDisplay[i].color
	var alpha = combatLogEntriesOnDisplay[i].alpha
	draw_text_color(logX, logY+(i*(string_height(text)+2)), text, color, color, color, color, alpha)
}