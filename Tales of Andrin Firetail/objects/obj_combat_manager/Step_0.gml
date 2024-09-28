var up_key = input("up");
var down_key = input("down");
var accept_key = input("enter");
var back_key = input("back");
drawSelector = true

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
if waitFrames<1{
	switch(step){
		case "Awaiting player input":
		break;
	
		case "Determine active combatant":
		//Determine who’s turn it is. 
			//List all combatants that are not 0HP and have not yet acted this round.
			canStillGo = [];
			array_copy(canStillGo, -1, combatants, 0, array_length(combatants))
			for (var i=array_length(canStillGo)-1;i>=0;i--;){
				if 	canStillGo[i].currentHP <= 0 || canStillGo[i].hasActed{
					array_delete(canStillGo, i, 1);	
				}
			}
		
			//see if we done here
			var stillAreMonsters = false
			for (var i=0 ; i<array_length(combatants); i++) {
				//show_debug_message(object_get_parent(combatants[i].object_index))
				if object_get_parent(combatants[i].object_index) == obj_enemy{
					if combatants[i].currentHP > 0{
						stillAreMonsters = true
					}
				}
			}
			if stillAreMonsters == false{
				view_set_xport(overworldViewport, overworldCameraX)
				view_set_yport(overworldViewport, overworldCameraY)
				view_visible[overworldViewport] = true
				view_visible[combatViewport] = false
				if instance_exists(obj_combat_menu){
					instance_destroy(menu);	
				}
				instance_destroy(self);
			}else{show_debug_message("There are this many enemies remaining: " + string(instance_number(obj_enemy)))}
		
			//Iterate, comparing speed to highestSpeed.
			var fastestRemainingCombatant = canStillGo[0];
			//@TODO Determine how to handle ties on speed.
			for (var i=0;i<array_length(canStillGo);i++;){
				if 	canStillGo[i].totalSpeed > fastestRemainingCombatant.totalSpeed{
					fastestRemainingCombatant = canStillGo[i];
				}
			}
	
			activeCombatant = fastestRemainingCombatant;
		
			// This line just for testing rn. Because of the diff in sprite sizes. Probably will remove.
			if object_get_parent(activeCombatant.object_index) == obj_enemy{activeCombatantScale = 1.2} else {activeCombatantScale = 1.6}
		
			originalScaleX = activeCombatant.image_xscale;
			originalScaleY = activeCombatant.image_yscale;
			activeCombatant.image_xscale = originalScaleX * activeCombatantScale;
			activeCombatant.image_yscale = originalScaleY * activeCombatantScale;
		
			step = "Open menu";
		break;
	
		case "Open menu":
		//On a turn:
			targets = [];
			activeCombatant.isActive = true;
			if instance_exists(obj_combat_menu){
			instance_destroy(menu);	
			}
			//Reduce their counters by 1. (Statuses/cooldowns)
				//@TODO Figure this out.
		
			action = {name:"empty"};
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
				menu = instance_create_depth(combatCameraX+40,combatCameraY+10,0,obj_combat_menu,{combatManagerID:id,inventory:inventory, spells:spells, specialActions:specialActions, attacks:attacks});
				step = "Awaiting player input"; //Menu will set combatManagerID.step = "Do action";
			}
			
			//If enemy, determine action based on AI rules.
			if activeCombatant.object_index == obj_enemy || object_get_parent(activeCombatant.object_index) == obj_enemy{
				action = activeCombatant.getAction();
				array_push(targets, action.targetID); //targets = [action.targetID]
				if action.bonus_targetID != ""{array_push(targets, action.bonus_targetID);}
				step = "Do action";
			}
	break;
	
		case "Select targets":
			//show_debug_message(typeof(targets))
			//show_debug_message(targets[0])
			if back_key{step = "Open menu";}
			else if array_contains(preDesignatedTargets, string_lower(targets[0])){
				if accept_key{
					step = "Do action";
					break;	
				}
			}
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
		function doAction(theseTargets){
				var bonusTargetStartHP = 0;
				var targetStartHP = 0;
				var bonusTargetEndHP = 0;
				var targetEndHP = 0;
			
				if typeof(theseTargets) != "array"{theseTargets = [theseTargets]}
				action.targetID = theseTargets[0];	//Could be an objectID or "all" or "self" 
												//@TODO Handle these non-ID cases. /\
			
				switch(action.targetID)
				{
					case "self":
					targetStartHP = activeCombatant.currentHP;
					break;
				
					case "all":
					//@TODO Figure this out
					show_debug_message("Add this code you dumy!");
					break;
				
					default:
					targetStartHP = action.targetID.currentHP;
				}
			
				if array_length(theseTargets) == 2 {
					action.bonus_targetID = theseTargets[1];
					bonusTargetStartHP = action.bonus_targetID.currentHP;
					}
			
				var results = activeCombatant.doAction(action);	   // Should return {damage:int(or 'miss'), effect:str, animation_index:asset}
				displayActionAnimation(theseTargets, results);
			
				switch(action.targetID)
				{
					case "self":
					targetEndHP = activeCombatant.currentHP;
					break;
				
					case "all":
					//@TODO Figure this out
					show_debug_message("Add this code you dumy!");
					break;
				
					default:
					targetEndHP = action.targetID.currentHP;
				}
			
				if targetEndHP < targetStartHP{
						action.targetID.isTakingDamage = true;
					}
			
				if array_length(theseTargets) == 2 {
					bonusTargetEndHP = action.bonus_targetID.currentHP;
					if bonusTargetEndHP < bonusTargetStartHP{
						action.bonus_targetID.isTakingDamage = true;
					}
				}
				// Push the log message
				logMessage = {
					text: results.logMessage,	
					color: c_white,
					frames: 90, //How many frames message is on screen
					alpha: 1
				}
				// Edit the logMessage to replaced keywords with the correct variables.
				for(var i=0; i<array_length(logMessage.text); i++){
					switch(logMessage.text[i].text){
						case "*ACTIVE": 
							logMessage.text[i].text = activeCombatant.combatName 
							logMessage.text[i].color = activeCombatant.combatLogColor
							break;
						
						case "*TARGET": 
							logMessage.text[i].text = action.targetID.combatName 
							logMessage.text[i].color = action.targetID.combatLogColor
							break;
						
						case "*DAMAGE": 
							logMessage.text[i].text = string(targetStartHP-targetEndHP) 
							logMessage.text[i].color = c_white
							break;
						
						case "*HEALING": 
							logMessage.text[i].text = string(targetEndHP-targetStartHP) 
							logMessage.text[i].color = c_yellow
							break;
					}
				}
				array_push(self.combatLogEntriesOnDisplay, logMessage)
				array_push(self.combatLogEntries, logMessage)
		}
			if action.name != "empty" && array_length(targets) != 0{
				if string_lower(targets[0]) == "all"{
					for (var i=0; i<array_length(combatants); i++){
						doAction(combatants[i])
					}
					action.targetID = "all"
				}
				else if string_lower(targets[0]) == "all enemies"{
					for (var i=0; i<array_length(combatants); i++){
						if object_get_parent(combatants[i].object_index) == obj_enemy{
							doAction(combatants[i])
						}
					}
					action.targetID = "all enemies"
				}
				else{
					doAction(targets)	
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
		 
			if !damageAnimationsAreRunning && !instance_exists(obj_action_animation){
			//&& !instance_exists(obj_damage_value_animation){			
				activeCombatant.hasActed = true;	
				action = {name:"empty"};
				targets = [];
				step = "Bring our yer dead";
				waitFrames = 5
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
}else{
	waitFrames--
}