	aaron = global.OVERWORLD_ID_AARON
	val = aaron.inventory
	var stuff = []
	for (var i = 0; i<array_length(val); i++){
		array_push(stuff, val[i].name)	
	}
	val = stuff
	
	
	if instance_number(obj_combat_aaron){
		count+=1
		if count>10{
		aaron = instance_find(obj_combat_aaron, 0)
		val = aaron.totalSpeed
		}
	}else{
		count = 0
	}

	x = aaron.x
	y = aaron.y - aaron.sprite_height - 3
	
	x -= string_width(val)/2