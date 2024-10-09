function close_combat(){
	view_set_xport(overworldDetails.overworldViewport, overworldDetails.overworldCameraX)
	view_set_yport(overworldDetails.overworldViewport, overworldDetails.overworldCameraY)
	view_visible[overworldDetails.overworldViewport] = true
	view_visible[overworldDetails.combatViewport] = false	
}

//This may need to exist in the Create event and just poop out a struct with all the deets.
function get_character_fight_exp(character){
	// Should total monster EXP, check any modifiers for EXP and return the total.
	// Could possibly return for example {exp: 45, bonus_exp: 15}. If we want the animation to be slightly different for those with a bonus to EXP.
}



//This should display loot, add it to the player inventory, give EXP, and handle levelups.

//    Display all loot gained
	
//    Animate EXP bars going up
	
//    Handle levelups whatever that means...

//      Probably means showing a levelup animation and allowing the player to make any choices they may need to 