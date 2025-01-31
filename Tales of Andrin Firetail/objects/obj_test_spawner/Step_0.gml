if place_meeting(x, y, obj_overworld_aaron){
	if !alreadySpawned{
		instance_create_depth(x,y, 0, obj_inventory_menu)
		alreadySpawned = true
	}
	cooldown = max_cooldown_frames
}else{cooldown--}

if alreadySpawned && cooldown == 0{ alreadySpawned = false}

if alreadySpawned{image_alpha = 0.4}
else{image_alpha = 1}