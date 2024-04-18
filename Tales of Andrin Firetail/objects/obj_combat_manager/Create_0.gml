//CombatDetailStruct should contain enemy ids [], enemy positioning, round timer events, [MORE?]

//-------------------COMBAT START----------------------

	//Begin transition animation

	//move to combat room

	//Create list of combat object IDs.
		// Aaron + 0-3 party members.
		// Key enemies
		// Random enemies created by their own function. Overworld enemy will generate it.


	//Determine positioning
		//Look at globalvar for party
		var charAaron = global.OVERWORLD_ID_AARON;
		var charA = global.OVERWORLD_ID_A;
		var charB = global.OVERWORLD_ID_B;
		var charC = global.OVERWORLD_ID_C;
		var IDsorder = [];
		
		//Make sure group size is accurate.
		var partyIDs = [charAaron, charA, charB, charC];
		for (var i=0;i<array_length(partyIDs);i++;){
			if 	partyIDs[i] == 0{
				array_delete(partyIDs, i, 1);	
			}
		}
		
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
