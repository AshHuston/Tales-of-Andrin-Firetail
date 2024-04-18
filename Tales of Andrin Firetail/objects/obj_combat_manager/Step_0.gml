	
	//-------------------COMBAT CLOCK----------------------

	//Determine who’s turn it is. 
		//List all combatants that are not 0HP and have not yet acted this round.
		//Iterate, comparing speed to highestSpeed. 
		//Highest who has not yet gone can now go.
		
	//On a turn:
		//Set an indicator flag that this combatant is active
		//Set hasActed flag to true.
		//Reduce their counters by 1. (Statuses/cooldowns)
		//Display character menu, select action/target(s).
			//If enemy, determine action based on AI rules.
		//Perform action. (spell, ability, attack, item, etc.)

	//Check for anyone below 0HP.
		//If so, animate death/down and set flag.

	//Check if everyone has gone, if so,
		//Set all hasActed flags to false.
		//Check for any round count events from struct. (i.e. a round-limited battle.)
		//Repeat from the top
