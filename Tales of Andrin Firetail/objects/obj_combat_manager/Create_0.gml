//CombatDetailStruct should contain enemy ids [], enemy positioning, round timer events, [MORE?]

/**
 * Creates the combat characters for party members.
 * @param {any*} partyIDs overworld object IDs for party members.
 * @returns {array} obj_combat_party_member object IDs, in the order the overworld ids were provided.
 */
function createPartyCombatObjects(partyIDs){
	var combatObjectIDs = [];
	var combatCharID
	
	for (var i=0; i<array_length(partyIDs); i++;){
		//show_debug_message(partyIDs[i]);
		if i==0 {combatCharID = instance_create_depth(x,y, 0, obj_combat_aaron, {associatedCharacterID:partyIDs[i]});}
		else{combatCharID = instance_create_depth(x,y, 0, obj_combat_party_member, {associatedCharacterID:partyIDs[i]});}
		array_push(combatObjectIDs, combatCharID);
	}
	
	return combatObjectIDs;
}



//-------------------COMBAT START----------------------

	//Begin transition animation

	//move to combat room

	//Create list of combat object IDs.
		combatants = []
		// Aaron + 0-3 party members.
		var charAaron = global.OVERWORLD_ID_AARON;
		var charA = global.OVERWORLD_ID_A;			// Currently these all are the overworld IDs,
		var charB = global.OVERWORLD_ID_B;			// they will need to be the actual combat objects.
		var charC = global.OVERWORLD_ID_C;			// Right?
		
		
		//Make sure group size is accurate.
		var partyIDs = [charAaron, charA, charB, charC];
			
		for (var i=0;i<array_length(partyIDs);i++;){
			//show_debug_message(partyIDs[i])
			if 	partyIDs[i] == 0{
				array_delete(partyIDs, i, 1);
				i = 0;
			}
		}
		
		partyIDs = createPartyCombatObjects(partyIDs);
		// Enemies are either premade or created by their own function. Overworld enemy will generate it.
		// Either way, their ids will get passed in via the struct.


	//Determine positioning
		//Look at globalvar for party
		IDsorder = [];
				
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
		var mobs = [mob1, mob2, mob3, mob4, mob5]; //This has us maxing out theorerically at 5 enemies, but depending on what our highest number is we can just add more, it will ignore empty ones.
		
		//Combine combatants
		for (var i=0;i<array_length(mobs);i++;){
			if mobs[i] != ""{
				array_push(combatants, mobs[i]);
			}
		}
		
		for (var i=0;i<array_length(partyIDs);i++;){
			array_push(combatants, partyIDs[i]);
		}
		
		
		
	//Start combat clock
	step = "Determine active combatant";
	activeCombatant = combatants[0];
	action = {name:"empty"};
	targets = [];
	menu = "";
	hovering = -1;
	canStillGo = []
	
	//global.COMBATANTS = combatants;
	array_copy(global.COMBATANTS, -1, combatants, 0, array_length(combatants))