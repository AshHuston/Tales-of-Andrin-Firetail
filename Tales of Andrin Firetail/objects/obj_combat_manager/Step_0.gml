var step = "Determine active combatant";	

	//-------------------COMBAT CLOCK----------------------
switch(step){
	
	case "Determine active combatant":
	//Determine who’s turn it is. 
		//List all combatants that are not 0HP and have not yet acted this round.
		var canStillGo = combatants;
		for (var i=0;i<array_length(combatants);i++;){
			if 	combatants[i].currentHP <= 0 || combatants[i].hasActed{
				array_delete(canStillGo, i, 1);	
			}
		}
		
		//Iterate, comparing speed to highestSpeed.
		var highestSpeed = 0;
		var fastestRemainingCombatant = "";
		//@TODO Determine how to handle ties on speed.
		for (var i=0;i<array_length(canStillGo);i++;){
			if 	canStillGo[i].totalSpeed >= highestSpeed{
				highestSpeed = canStillGo[i].totalSpeed;
				fastestRemainingCombatant = canStillGo[i];
			}
		}
	
		var activeCombatant = fastestRemainingCombatant;
		step = "Run turn";
	break;
	
	case "Run turn":
	//On a turn:
		activeCombatant.isActive = true;
		
		//Reduce their counters by 1. (Statuses/cooldowns)
			//@TODO Figure this out.
		
		//@TODO Display character menu, select action/target(s).
			// Will somehow utilize -> activeCombatant.menuTexture
			//If enemy, determine action based on AI rules.
			
		//Perform selected action. (spell, ability, attack, item, etc.)
			//@TODO 
			
		activeCombatant.hasActed = true;	
		
		step = "Bring our yer dead";
		
	case "Bring our yer dead":	
	//Check for anyone below 0HP.
		for (var i=0;i<array_length(combatants);i++;){
			if combatants[i].currentHP <= 0{
				combatants[i].isConscious = false;
			}
		}
		
		//If so, animate death/down.
			//@TODO Figure out how to do this. 
			//Probably setting the sprite to a death animation then a speed/index to do the last frame.
		
		step = "Reset check";
	break;
	
	case "Reset check":
	//Check if everyone has gone,
		var resetCycle = false;
		var totActed = 0
		for (var i=0;i<array_length(combatants);i++;){
			if combatants[i].hasActed == true{
				totActed++;
				if totActed == array_length(combatants){
					resetCycle = true;
				}
			}
		}
		
		if resetCycle == true{
			for (var i=0;i<array_length(combatants);i++;){
				combatants[i].hasActed = false;
			}
		
			//@TODO Check for any round count events from struct. (i.e. a round-limited battle.)
				// if roundEvents[] not empty, check for trigger rounds.
		
		}
		step = "Determine active combatant";
}