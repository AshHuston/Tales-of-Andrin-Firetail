	

	//-------------------COMBAT CLOCK----------------------
switch(step){
	case "Awaiting player input":
	break;
	
	case "Determine active combatant":
	//Determine who’s turn it is. 
		//List all combatants that are not 0HP and have not yet acted this round.
		var canStillGo = combatants;
		//show_debug_message(combatants)
		for (var i=0;i<array_length(combatants);i++;){
			if 	combatants[i].currentHP <= 0 || combatants[i].hasActed{
				array_delete(canStillGo, i, 1);	
			}
		}
		
		//Iterate, comparing speed to highestSpeed.
		var fastestRemainingCombatant = canStillGo[0];
		//@TODO Determine how to handle ties on speed.
		for (var i=0;i<array_length(canStillGo);i++;){
			if 	canStillGo[i].totalSpeed > fastestRemainingCombatant.totalSpeed{
				fastestRemainingCombatant = canStillGo[i];
			}
		}
	
		activeCombatant = fastestRemainingCombatant;
		step = "Open menu";
	break;
	
	case "Open menu":
	//On a turn:
		activeCombatant.isActive = true;
		
		//Reduce their counters by 1. (Statuses/cooldowns)
			//@TODO Figure this out.
		
		//@TODO Display character menu, select action/target(s).
			//@TODO move all the functionaility of obj_title_menu to this object
			action = {name:"empty"};
			targets = [];
			if activeCombatant.object_index == obj_combat_party_member || object_get_parent(activeCombatant.object_index) == obj_combat_party_member{
				var attacks = activeCombatant.listAttacks();
				var specialActions = activeCombatant.listSpecialActions();
				var inventory = activeCombatant.listItems();
				var spells = activeCombatant.listSpells();
			
			
			// Might somehow utilize -> activeCombatant.menuTexture   \/
				instance_create_depth(x,y,0,obj_combat_menu,{combatManagerID:id,inventory:inventory, spells:spells, specialActions:specialActions, attacks:attacks});
				step = "Awaiting player input"; //Menu will set combatManagerID.step = "Do action";
			}
			
			//If enemy, determine action based on AI rules.
			if activeCombatant.object_index == obj_enemy || object_get_parent(activeCombatant.object_index) == obj_enemy{
				action = activeCombatant.getAction();
				step = "Do action";
			}
	break;
	
	case "Do action":
		if action.name != "empty" && array_length(targets) != 0 {
			action.targetID = targets[0]; //Could be an ID or "all" or "self"
			if array_length(targets) == 2 {action.bonus_targetID = targets[1];}
			
			activeCombatant.doAction(action);
		
			activeCombatant.hasActed = true;	
			action = {name:"empty"};
			targets = [];
			step = "Bring our yer dead";
		}
	break;
		
	case "Bring our yer dead":
	//Check for anyone below 0HP.
		for (var i=0;i<array_length(combatants);i++;){
			if combatants[i].currentHP <= 0{
				//combatants[i].currentHP = 0; // Could add that if we don't want negetive HP.
				combatants[i].isConscious = false;
			}
		}
		
		//We could toy around with being unconcious but having HP means you may wake up.
		
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