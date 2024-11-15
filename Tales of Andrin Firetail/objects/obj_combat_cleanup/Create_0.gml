event_inherited()

fadeout = noone
fadeoutFinished = false
shading = 0
X = 0
Y = 1
overworldViewport = overworldDetails.overworldViewport
overworldCameraX = overworldDetails.overworldCameraX
overworldCameraY = overworldDetails.overworldCameraY
combatViewport = overworldDetails.combatViewport
overworld_mob = overworldDetails.overworld_mob
image_speed = 0.1
isAnimating = {
	expBars : true,
	lootDisplay : true,
}
/*
show_debug_message("-----------------------------------------------------------------------------------------")
show_debug_message("ovw details")
show_debug_message(overworldDetails)

show_debug_message("-----------------------------------------------------------------------------------------")
show_debug_message("loot")
show_debug_message(loot)
*/
show_debug_message("-----------------------------------------------------------------------------------------")
show_debug_message("experience")
show_debug_message(experience)
//*/

function get_character_fight_exp(character, expereince = experience){
	// Should total monster EXP, check any modifiers for EXP and return the total.
	var totalExp = {base_exp: 0, bonus_exp: 0}
	for (var i=0 ; i<array_length(experience); i++) {
		totalExp.base_exp += experience[i].exp_value
		// Should also check for bonus EXP too. However we do that.
	}	
	// Could return: {base_exp: 45, bonus_exp: 15}. For special animation for bonus EXP.
	return totalExp.base_exp
}

characterDisplayVals = []
for (var i=0 ; i<array_length(partyMemberIDs); i++) {
	var thisCharStuff = {
		name : partyMemberIDs[i].name,
		characterID : partyMemberIDs[i],
		startExp : partyMemberIDs[i].totalExp - global.EXP_SCALE[partyMemberIDs[i].level],
		endExp : 0, //Edits in a few lines.
		currentLevel : partyMemberIDs[i].level,
		expForLevelup : 0,
		alreadyAdded : 0,
		totalAdded : get_character_fight_exp(partyMemberIDs[i])
		
	}
	partyMemberIDs[i].totalExp += thisCharStuff.totalAdded
	thisCharStuff.endExp = partyMemberIDs[i].totalExp - global.EXP_SCALE[partyMemberIDs[i].level]
	thisCharStuff.expForLevelup = global.EXP_SCALE[partyMemberIDs[i].level+1] - global.EXP_SCALE[partyMemberIDs[i].level]
	array_push(characterDisplayVals, thisCharStuff)
}

#region Add loot
var inventory = global.OVERWORLD_ID_AARON.inventory
for (var i=0 ; i<array_length(loot); i++) {
	if loot[i].name == "gold" {
		global.OVERWORLD_ID_AARON.gold += loot[i].qty
	}else{
		var item = loot[i].itemInfo
		var itemExists = false
		for (var n=0 ; n<array_length(inventory); n++) {
			if inventory[n].name = item.name{
				itemExists = true
				inventory[n].quantity += item.qty
			}
		}
		
		if !itemExists{
			array_push(inventory, item)
		}
	}
}
#endregion