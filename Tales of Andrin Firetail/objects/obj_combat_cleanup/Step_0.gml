function close_combat(){
	view_set_xport(overworldDetails.overworldViewport, overworldDetails.overworldCameraX)
	view_set_yport(overworldDetails.overworldViewport, overworldDetails.overworldCameraY)
	view_visible[overworldDetails.overworldViewport] = true
	view_visible[overworldDetails.combatViewport] = false	
	for (var i=0 ; i<array_length(global.COMBATANTS); i++) {
		instance_destroy(global.COMBATANTS[i])	
	}
	instance_destroy(self)
}

var up_key = input("up");
var down_key = input("down");
var accept_key = input("enter");
var back_key = input("back");

//If everything is done processing/animating then it will allow a button-press to close combat.
var animations_done = true
var keys = variable_struct_get_names(isAnimating);
for (var i = 0; i < array_length(keys); i++){
	if variable_struct_get(isAnimating, keys[i]){
		animations_done = false
	}
}

if animations_done{
	if accept_key{
		fadeout = instance_create_depth(x, y, 0, obj_combatFadeInOut)
	}
}
