var up_key = keyboard_check_pressed(vk_up);
var down_key = keyboard_check_pressed(vk_down);
var accept_key = keyboard_check_pressed(vk_return);

	//-------------------COMBAT CLOCK----------------------
switch(step){
	case "Awaiting player input":
	break;
	
	case "Determine active combatant":
	
	if !instance_exists(obj_enemy) && instance_exists(obj_combat_menu){
		instance_destroy(menu);	
		instance_destroy(self);
	}
	
	//Determine who’s turn it is. 
		//List all combatants that are not 0HP and have not yet acted this round.
		canStillGo = [];
		array_copy(canStillGo, -1, combatants, 0, array_length(combatants))
		//show_debug_message(combatants)
		for (var i=array_length(canStillGo)-1;i>=0;i--;){
			if 	canStillGo[i].currentHP <= 0 || canStillGo[i].hasActed{
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
		if instance_exists(obj_combat_menu){
		instance_destroy(menu);	
		}
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
				menu = instance_create_depth(x+40,y+10,0,obj_combat_menu,{combatManagerID:id,inventory:inventory, spells:spells, specialActions:specialActions, attacks:attacks});
				step = "Awaiting player input"; //Menu will set combatManagerID.step = "Do action";
			}
			
			
			//If enemy, determine action based on AI rules.
			if activeCombatant.object_index == obj_enemy || object_get_parent(activeCombatant.object_index) == obj_enemy{
				action = activeCombatant.getAction();
				targets = [action.targetID]
				if action.bonus_targetID != ""{array_push(targets, action.bonus_targetID);}
				step = "Do action";
			}
	break;
	
	
	case "Select targets":
			//Figure out how to set action.targetID and action.bonus_targetID.
			//I feel like this SHOULD be easy.
			//Maybe just loop though the options and display an indicateor over the selected target.
			
			
			var combatantsLength = array_length(combatants);
			if down_key{hovering++;}
			if up_key{hovering--;}
			if hovering>=combatantsLength{hovering=0};
			if hovering<0 {hovering=combatantsLength-1};
			if object_get_parent(combatants[hovering].object_index) != obj_enemy{
				
				if down_key{hovering++}
				else{hovering--}
				
			}
			
			if accept_key{
				targets[0] = combatants[hovering];
				step = "Do action";
				}
			if action.actionType = "item"{
				if action.canTarget = "self"{
					targets[0] = "self";
					step = "Do action";
					}
				}
			
	break;
	
	
	case "Do action":
		if action.name != "empty" && array_length(targets) != 0 {
			action.targetID = targets[0]; //Could be an ID or "all" or "self"
			if array_length(targets) == 2 {action.bonus_targetID = targets[1];}
			
			var results = activeCombatant.doAction(action); // Should return {damage:int(or 'miss'), effect:str, animation_index:asset}
						
			displayActionAnimation(action.targetID, results); //@TODO Write this lol. Probably contains this - displayDamage(action.targetID, results.damage);
			
			
			//Maybe setting this in a seperate, post-aniamtion step. TBD. Prolly not bc that's slow
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
				if object_get_parent(combatants[i].object_index) == obj_enemy{
					combatants[i].image_angle = 270;
					array_delete(combatants, i, 1)
					array_copy(global.COMBATANTS, -1, combatants, 0, array_length(combatants))
				}
				else{
					combatants[i].isConscious = false;
					combatants[i].currentHP = 0;
				}
				array_copy(global.COMBATANTS, -1, canStillGo, 0, array_length(canStillGo))
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