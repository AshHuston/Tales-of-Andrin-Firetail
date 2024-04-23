if global.OVERWORLD_ID_AARON != id{global.OVERWORLD_ID_AARON = id;}

//Check for instance of combat object. if none, make one.
if !instance_exists(obj_combat_aaron){
	instance_create_depth(x,y,0,obj_combat_aaron);
}


if !instance_exists(obj_combat_manager){
	instance_create_depth(x,y,0,obj_combat_manager);
}

//if !instance_exists(obj_title_menu){
//	instance_create_depth(x,y,0,obj_title_menu,{inventory:inventory, spells:[], specialActions:[{name:"Ephrin's Queen", powerLevel:9001}], attacks:[{name:"Punch", maxDmg:1}]});
//}
//  make this be created in the combat manager and also pass in the managers id so it can give the selected action as a manager variabvlke.