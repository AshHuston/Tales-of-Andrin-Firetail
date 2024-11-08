event_inherited()


X = 0
Y = 1
overworldViewport = overworldDetails.overworldViewport
overworldCameraX = overworldDetails.overworldCameraX
overworldCameraY = overworldDetails.overworldCameraY
combatViewport = overworldDetails.combatViewport
overworld_mob = overworldDetails.overworld_mob
image_speed = 0.1
isAnimating = {
	expBar1 : true,
	expBar2 : true,
	expBar3 : true,
	expBar4 : true,
	lootDisplay : true,
	
}

show_debug_message("-----------------------------------------------------------------------------------------")
show_debug_message("ovw details")
show_debug_message(overworldDetails)

show_debug_message("-----------------------------------------------------------------------------------------")
show_debug_message("loot")
show_debug_message(loot)

show_debug_message("-----------------------------------------------------------------------------------------")
show_debug_message("experience")
show_debug_message(experience)

function get_character_fight_exp(character, expereince = experience){
	// Should total monster EXP, check any modifiers for EXP and return the total.
	var totalExp = {base_exp: 0, bonus_exp: 0}
	for (var i=0 ; i<array_length(experience); i++) {
		totalExp.base_exp += experience[i].exp_value
		// Should also check for bonus EXP too. However we do that.
	}	
	// Could possibly return for example {base_exp: 45, bonus_exp: 15}. If we want the animation to be slightly different for those with a bonus to EXP.
	return totalExp.base_exp
}
#region Add EXP
originalExp = []
for (var i=0 ; i<array_length(partyMemberIDs); i++) {
	var thisCharStuff = {
		name : partyMemberIDs[i].name,
		characterID : partyMemberIDs[i],
		startExp : 0 + partyMemberIDs[i].totalExp
	}
	partyMemberIDs[i].totalExp += get_character_fight_exp(partyMemberIDs[i])
}
#endregion
#region Add loot
var inventory = global.OVERWORLD_ID_AARON.inventory
for (var i=0 ; i<array_length(loot); i++) {
	if loot[i].name == "gold" {
		global.OVERWORLD_ID_AARON.gold += loot[i].qty
	}else{
		var item = loot[i].itemInfo
		array_push(inventory, item) //@TODO Currently doesnt check if theres existing copies of the item in the inventory... shoudl add that.
	}
}
#endregion