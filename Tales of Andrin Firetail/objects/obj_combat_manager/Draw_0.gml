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