


if framecount >= 300{
	var Z1;	
	var Z2;
	if !instance_exists(obj_combat_zombie){
		Z1 = instance_create_depth(x,y,0,obj_combat_zombie);
		Z2 = instance_create_depth(x,y,0,obj_combat_zombie);
	}
	
	
	instance_create_depth(0,0,0,obj_combat_manager, {mob1:Z1, mob2:Z2})
}


framecount++