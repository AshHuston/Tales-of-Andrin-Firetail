	
	//-------------------COMBAT CLOCK----------------------

	//Determine who’s turn it is. 
		//List all combatants that are not 0HP and have not yet acted this round.
		var canStillGo = combatants;
		for (var i=0;i<array_length(combatants);i++;){
			if 	combatants[i].currentHP <= 0 || combatants[i].hasActed{
				array_delete(combatants, i, 1);	
			}
		}
		
		//Iterate, comparing speed to highestSpeed.
		var highestSpeed = 0;
		var fastestCombatant = "";
		for (var i=0;i<array_length(combatants);i++;){
			if 	combatants[i].totalSpeed >= highestSpeed{
				highestSpeed = combatants[i].totalSpeed;
				fastestCombatant = combatants[i];
			}
		}
	
		//Highest who has not yet gone can now go.
		var activeCombatant = fastestCombatant;
		
	//On a turn:
		//Set an indicator flag that this combatant is active
		activeCombatant.isActive = true;
		//Set hasActed flag to true.
		activeCombatant.hasActed = true;
		
		//Reduce their counters by 1. (Statuses/cooldowns)
			//@TODO Figure this out.
		
		//Display character menu, select action/target(s).
			// Will somehow utilize -> activeCombatant.menuTexture
			//If enemy, determine action based on AI rules.
		//Perform action. (spell, ability, attack, item, etc.)

	//Check for anyone below 0HP.
		//If so, animate death/down and set flag.

	//Check if everyone has gone, if so,
		//Set all hasActed flags to false.
		//Check for any round count events from struct. (i.e. a round-limited battle.)
		//Repeat from the top
