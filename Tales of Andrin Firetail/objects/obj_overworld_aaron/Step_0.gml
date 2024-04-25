if global.OVERWORLD_ID_AARON != id{global.OVERWORLD_ID_AARON = id;}

//Check for instance of combat object. if none, make one.
if !instance_exists(obj_combat_aaron){
	//instance_create_depth(x,y,0,obj_combat_aaron);
}


if !instance_exists(obj_combat_manager) && framecount >= 100{
	instance_create_depth(x,y,0,obj_combat_manager, {mob1:instance_find(obj_enemy, 0), mob2:instance_find(obj_enemy, 1), mob3:instance_find(obj_enemy, 2), mob4:instance_find(obj_enemy, 3), mob5:instance_find(obj_enemy, 4)});
}
framecount++