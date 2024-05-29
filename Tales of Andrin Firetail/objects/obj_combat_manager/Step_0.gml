var up_key = keyboard_check_pressed(vk_up);
var down_key = keyboard_check_pressed(vk_down);
var accept_key = keyboard_check_pressed(vk_return);
var back_key = keyboard_check_pressed(vk_backspace);

function displayActionAnimation(targetsArr, results){
	target = targetsArr[0];
	if results.animation_index != "None" && results.mainDmg != -1{
		instance_create_depth(target.x, target.y, -100, obj_action_animation, {image_speed: 1.5, sprite_index: results.animation_index});
		if array_length(targetsArr) == 2{
			secondary_target = targetsArr[1];
			instance_create_depth(secondary_target.x, secondary_target.y, -100, obj_action_animation, {sprite_index:results.animation_index});
		}
	}
	
	if struct_exists(results, "mainDmg"){
		instance_create_depth(target.x, target.y, -100, obj_damage_value_animation, {dmgAmt: results.mainDmg});	
			
	}
	
	//@TODO Add pause and then animate status effect if applied. //And probably not if aleady affected.
	
	
	if array_length(targetsArr) == 2{
		secondary_target = targetsArr[1];
		instance_create_depth(secondary_target.x, secondary_target.y, -100, obj_action_animation, {sprite_index:results.animation_index});
	}
}

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
		
		// This line just for testing rn. Probably will remove.
		if object_get_parent(activeCombatant.object_index) == obj_enemy{activeCombatantScale = 1.2} else {activeCombatantScale = 1.6}
		
		originalScaleX = activeCombatant.image_xscale;
		originalScaleY = activeCombatant.image_yscale;
		activeCombatant.image_xscale = originalScaleX * activeCombatantScale;
		activeCombatant.image_yscale = originalScaleY * activeCombatantScale;
		
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
				var attacks = [];
				array_copy(attacks, -1, activeCombatant.listAttacks(), 0, array_length(activeCombatant.listAttacks()));
				var specialActions = []
				array_copy(specialActions, -1, activeCombatant.listSpecialActions(), 0, array_length(activeCombatant.listSpecialActions()));
				var inventory = [];
				array_copy(inventory, -1, activeCombatant.listItems(), 0, array_length(activeCombatant.listItems()));
				var spells = [];
				array_copy(spells, -1, activeCombatant.listSpells(), 0, array_length(activeCombatant.listSpells()));
				
			
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
		if back_key{step = "Open menu";} 
		else{
			var combatantsLength = array_length(combatants);
			if down_key{hovering++;}
			if up_key{hovering--;}
			if hovering>=combatantsLength{hovering=0};
			if hovering<0 {hovering=combatantsLength-1};
			for (var i=0;i<3;i++){
				if object_get_parent(combatants[hovering].object_index) != obj_enemy{	
					if down_key{hovering++}
					else{hovering--}	
				}
				if hovering>=combatantsLength{hovering=0};
				if hovering<0 {hovering=combatantsLength-1};
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
		}
	break;
	
	case "Do action":
		if action.name != "empty" && array_length(targets) != 0 {
			
			var bonusTargetStartHP = 0;
			var targetStartHP = 0;
			var bonusTargetEndHP = 0;
			var targetEndHP = 0;
			
			action.targetID = targets[0]; //Could be an objectID or "all" or "self" //@TODO Handle these non-ID cases.
			
			switch(action.targetID)
			{
				case "self":
				targetStartHP = activeCombatant.currentHP;
				break;
				
				case "all":
				show_debug_message("Add this code you dumy!");
				break;
				
				default:
				targetStartHP = action.targetID.currentHP;
			}
			
			if array_length(targets) == 2 {
				action.bonus_targetID = targets[1];
				bonusTargetStartHP = action.bonus_targetID.currentHP;
				}
			
			var results = activeCombatant.doAction(action);	   // Should return {damage:int(or 'miss'), effect:str, animation_index:asset}
			displayActionAnimation(targets, results);
			
			switch(action.targetID)
			{
				case "self":
				targetEndHP = activeCombatant.currentHP;
				break;
				
				case "all":
				show_debug_message("Add this code you dumy!");
				break;
				
				default:
				targetEndHP = action.targetID.currentHP;
			}
			
			
			if targetEndHP < targetStartHP{
					action.targetID.isTakingDamage = true;
				}
			
			if array_length(targets) == 2 {
				bonusTargetEndHP = action.bonus_targetID.currentHP;
				if bonusTargetEndHP < bonusTargetStartHP{
					action.bonus_targetID.isTakingDamage = true;
				}
			}
			
			step = "Running animation";
			
		}
	break;
	
	case "Running animation":
		var damageAnimationsAreRunning = false;
		for (var i =0; i<array_length(combatants); i++;){
			if combatants[i].isTakingDamage{
				damageAnimationsAreRunning = true;	
			}
		}
		 
		if damageAnimationsAreRunning == false && instance_exists(obj_action_animation) == false{
		//&& !instance_exists(obj_damage_value_animation){			
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
		
		
		activeCombatant.image_xscale = originalScaleX; //Seemed like the best place to put this I guess.
		activeCombatant.image_yscale = originalScaleY;
		
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