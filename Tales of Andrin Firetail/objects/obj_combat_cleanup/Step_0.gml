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




//    Animate EXP bars going up		@TODO
//		Handle animating the start of the NEW level bar when leveling

//    Handle levelups whatever that means...		@TODO
//      Probably means showing a levelup animation and allowing the player to make any choices they may need to 




//If everything is done processing then it will close combat.
var keys = variable_struct_get_names(isAnimating);
for (var i = 0; i < array_length(keys); i++) {
    var key = keys[i];
    var value = variable_struct_get(isAnimating, key);
	if value == true{
		continue	
	}
	close_combat()
}

if keyboard_check_pressed(vk_space){
close_combat()
}