	aaron = global.OVERWORLD_ID_AARON
	val = aaron.inventory
	val = global.GAME_IS_PAUSED
	var stuff = []
	for (var i = 0; i<array_length(val); i++){
		array_push(stuff, val[i].name)	
	}
	//val = stuff
	
	
	if instance_number(obj_combat_aaron){
		count+=1
		if count>10{
			aaron = instance_find(obj_combat_aaron, 0)
			var coords = []
			for (var i = 0; i<array_length(global.COMBATANTS); i++){
				if object_get_parent(global.COMBATANTS[i].object_index) == obj_enemy{
					array_push(coords, [global.COMBATANTS[i].x, global.COMBATANTS[i].y])	
				}
			}
			val = coords
			//val = global.COMBATANTS
			}
	}else{
		count = 0
	}

	x = aaron.x
	y = aaron.y - aaron.sprite_height - 3
	
	x -= string_width(val)/2