if global.OVERWORLD_ID_AARON != id{global.OVERWORLD_ID_AARON = id;}

//Check for instance of combat object. if none, make one.
if !instance_exists(obj_combat_aaron){
	instance_create_depth(x,y,0,obj_combat_aaron);
}