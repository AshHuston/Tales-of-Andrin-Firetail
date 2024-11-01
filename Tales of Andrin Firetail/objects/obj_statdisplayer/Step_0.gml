	aaron = global.OVERWORLD_ID_AARON
	val = aaron.activeEffects
	if instance_number(obj_combat_aaron){
		count+=1
		if count>10{
		aaron = instance_find(obj_combat_aaron, 0)
		val = aaron.totalSpeed
		}
	}

	x = aaron.x
	y = aaron.y - aaron.sprite_height - 3
	
	x -= string_width(val)/2

	