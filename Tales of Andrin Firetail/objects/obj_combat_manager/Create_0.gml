//CombatDetailStruct should contain enemy ids [], enemy positioning, round timer events, [MORE?]

/**
 * Creates the combat characters for party members.
 * @param {any*} partyIDs overworld object IDs for party members.
 * @returns {array} object IDs, in the order the overworld ids were provided.
 */
function createPartyCombatObjects(partyIDs){
	var combatObjectIDs = [];
	
	for (var i=0; i<array_length(partyIDs); i++;){
		var combatCharID = instance_create_depth(x,y, 0, obj_combat_party_member, {associatedCharacterID:partyIDs[i]});
		array_push(combatObjectIDs, combatCharID);
	}
	
	return combatObjectIDs;
}


//-------------------COMBAT START----------------------

	//Begin transition animation

	//move to combat room

	//Create list of combat object IDs.
		// Aaron + 0-3 party members.
		var charAaron = global.OVERWORLD_ID_AARON;
		var charA = global.OVERWORLD_ID_A;			// Currently these all are the overworld IDs,
		var charB = global.OVERWORLD_ID_B;			// they will need to be the actual combat objects.
		var charC = global.OVERWORLD_ID_C;			// Right?
		
		
		//Make sure group size is accurate.
		var partyIDs = [charAaron, charA, charB, charC];
		for (var i=0;i<array_length(partyIDs);i++;){
			if 	partyIDs[i] == 0{
				array_delete(partyIDs, i, 1);	
			}
		}
		
		createPartyCombatObjects(partyIDs);
		
		// Enemies are either premade or created by their own function. Overworld enemy will generate it.
		// Either way, their ids will get passed in via the struct.


	//Determine positioning
		//Look at globalvar for party
		var IDsorder = [];
		
		
		
		//Fill out IDorder[]
		for(var i=0;i<array_length(global.COMBAT_ORDERING);i++;){
			switch(string_upper(global.COMBAT_ORDERING[i])){
				case "AARON": IDorder[i] = charAaron; break;
				case "A": IDorder[i] = charA; break;
				case "B": IDorder[i] = charB; break;
				case "C": IDorder[i] = charC; break;
			}
		}
		
		//Receive ids/positions from monster struct
	
	//Start combat clock
