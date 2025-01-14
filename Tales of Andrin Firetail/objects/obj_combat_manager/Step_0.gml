var up_key = input("up");
var down_key = input("down");
var accept_key = input("enter");
var back_key = input("back");
drawSelector = true
//print(step)
if step == "waiting for intro" && !instance_exists(obj_combat_intro){
	step = "Determine active combatant";
}

//@TODO Make this value changed when a spell/ability is selected but is illegal. Probably in the combatMenu.
if input("Y"){
	shakeSecondBarFrames = 15
}

//@TODO Decide actual input for combatLog
if keyboard_check_pressed(vk_alt){	//@DIAL
	if !hideCombatLog{hideCombatLog = true}
	else {hideCombatLog = false}
}

function displayActionAnimation(targetsArr, results){
	if typeof(targetsArr) != "array"{ targetsArr = [targetsArr] }
	target = targetsArr[0];
	if results.animation_index != "None" && results.mainDmg != -1{
		instance_create_depth(target.x, target.y, -100, obj_action_animation, {image_speed: 1.5, sprite_index: results.animation_index});
		if array_length(targetsArr) == 2{
			secondary_target = targetsArr[1];
			instance_create_depth(secondary_target.x, secondary_target.y, -100, obj_action_animation, {sprite_index:results.animation_index});
		}
	}
	
	if struct_exists(results, "mainDmg"){
		instance_create_depth(target.x, target.y, -100, obj_damage_value_animation, {dmgAmt: string(results.mainDmg)});	
			
	}
	
	//@TODO Add pause and then animate status effect if applied. //And probably not if aleady affected.
	
	
	if array_length(targetsArr) == 2{
		secondary_target = targetsArr[1];
		instance_create_depth(secondary_target.x, secondary_target.y, -100, obj_action_animation, {sprite_index:results.animation_index});
	}
}

function display_log_message(logMessage){
	if typeof(logMessage) == "string"{
		logMessage = {
					text:  logMessage,	
					color: c_white,
					frames: 90, //How many frames message is on screen
					alpha: 1
				}	
	}
	array_push(combatLogEntriesOnDisplay, logMessage)
	array_push(combatLogEntries, logMessage)
}
				
function set_ovw_character_stats(){
	for (var i=0 ; i<array_length(combatants); i++) {
		if object_get_parent(combatants[i].object_index) == obj_combat_party_member{
			var hp = combatants[i].currentHp
			combatants[i].associatedCharacterID.currentHp = hp
		}
	}
}				

#region Combat clock
// This allows us to manually enter an amount of frames to wait after any given thing before the combat clock 
// moves onto the next thing. Animations will persist though so thats good
if waitFrames<1{
	switch(step){
		case "Awaiting player input":
		break;
	#region Determine active combatant
		case "Determine active combatant":
		//Determine who’s turn it is. 
			//List all combatants that are not 0HP and have not yet acted this round.
			canStillGo = [];
			array_copy(canStillGo, -1, combatants, 0, array_length(combatants))
			for (var i=array_length(canStillGo)-1;i>=0;i--;){
				if 	canStillGo[i].currentHp <= 0 || canStillGo[i].hasActed{
					array_delete(canStillGo, i, 1);	
				}
			}
		
			//see if we done here
			var stillAreMonsters = false
			for (var i=0 ; i<array_length(combatants); i++) {
				if object_get_parent(combatants[i].object_index) == obj_enemy{
					if combatants[i].currentHp > 0{
						stillAreMonsters = true
					}
				}
			}
	#region Combat cleanup
			if stillAreMonsters == false{
				if instance_exists(obj_combat_menu){
					instance_destroy(menu);	
				}
				var overworld_details = {
					overworldViewport: overworldViewport,
					overworldCameraX: overworldCameraX,
					overworldCameraY: overworldCameraY,
					combatViewport: combatViewport,
					overworld_mob: overworld_mob
				}
				var experience = []
				var partyMemberIds = []
				for (var i=0 ; i<array_length(combatants); i++) {
					if object_get_parent(combatants[i].object_index) == obj_enemy{
						array_push(experience, {
							enemy: combatants[i].combatName, 
							exp_value: combatants[i].rewardExp
							})
					}
					if object_get_parent(combatants[i].object_index) == obj_combat_party_member || combatants[i].object_index == obj_combat_party_member{
						show_debug_message("added " + string(combatants[i].combatName))
						array_push(partyMemberIds, combatants[i].associatedCharacterID)
					}
				}
				instance_create_depth(0, 0, depth-1, obj_combat_cleanup, {
					loot: lootToDrop, 
					experience: experience, 
					overworldDetails: overworld_details,
					partyMemberIDs: partyMemberIds,
					cam: view_get_camera(combatViewport)
					})
				set_ovw_character_stats()
				instance_destroy(self);
		#endregion
			}else{
				//show_debug_message("There are this many enemies remaining: " + string(instance_number(obj_enemy)))
				}
		
			//Iterate, comparing speed to highestSpeed.
			var fastestRemainingCombatant = canStillGo[0];
			//@TODO Determine how to handle ties on speed. Right now it just gives it to the first one that is read.
			for (var i=0;i<array_length(canStillGo);i++;){
				if 	canStillGo[i].totalSpeed > fastestRemainingCombatant.totalSpeed{
					fastestRemainingCombatant = canStillGo[i];
				}
			}
	
			activeCombatant = fastestRemainingCombatant;
		
			// @TODO This line just for testing rn. Because of the diff in sprite sizes. Probably will remove.
			if object_get_parent(activeCombatant.object_index) == obj_enemy{activeCombatantScale = 1.3} else {activeCombatantScale = 1.7}
			
			// Notes active combatant by making them larger
			originalScaleX = activeCombatant.image_xscale;
			originalScaleY = activeCombatant.image_yscale;
			activeCombatant.image_xscale = originalScaleX * activeCombatantScale;
			activeCombatant.image_yscale = originalScaleY * activeCombatantScale;
		
			step = "Open menu";
		break;
	#endregion
	#region Open Menu
		case "Open menu":
		//On a turn:
			targets = [];
			activeCombatant.isActive = true;
			if instance_exists(obj_combat_menu){
				menu = instance_find(obj_combat_menu, 0)
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
				menu = instance_create_depth(combatCameraX+40,combatCameraY+10,0,obj_combat_menu,{combatManagerID:id, activeCombatant: activeCombatant, inventory:inventory, spells:spells, specialActions:specialActions, attacks:attacks});
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
	#endregion
	#region Select Targets
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
				for (var i=0;i<combatantsLength;i++){
					if object_get_parent(combatants[hovering].object_index) != obj_enemy || !combatants[hovering].isConscious{	
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
	#endregion
	#region Do Action
		case "Do action":
		activeCombatant.spendResource(action)
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
					targetStartHP = activeCombatant.currentHp;
					break;
				
					case "all":
					//@TODO Figure this out
					show_debug_message("Add this code you dumy!");
					break;
				
					default:
					targetStartHP = action.targetID.currentHp;
				}
			
				if array_length(theseTargets) == 2 {
					action.bonus_targetID = theseTargets[1];
					bonusTargetStartHP = action.bonus_targetID.currentHp;
					}
			
				var results = activeCombatant.doAction(action);
				displayActionAnimation(theseTargets, results);
				
				//@TESTING
				//print(results)
				
				switch(action.targetID)
				{
					case "self":
					targetEndHP = activeCombatant.currentHp;
					break;
				
					case "all":
					//@TODO Figure this out
					// I may have already handled this.
					show_debug_message("Add this code you dumy!");
					break;
				
					default:
					targetEndHP = action.targetID.currentHp;
				}
			
				if targetEndHP < targetStartHP{
						action.targetID.isTakingDamage = true;
					}
			
				if array_length(theseTargets) == 2 {
					bonusTargetEndHP = action.bonus_targetID.currentHp;
					if bonusTargetEndHP < bonusTargetStartHP{
						action.bonus_targetID.isTakingDamage = true;
					}
				}
				// Push the log message
				var json = json_stringify(results.logMessage)
				var logText = json_parse(json)
				
				logMessage = {
					text:  logText,	
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
							logMessage.text[i].text = results.mainDmg
							logMessage.text[i].color = c_white
							break;
						
						case "*HEALING": 
							logMessage.text[i].text = string(targetEndHP-targetStartHP) 
							logMessage.text[i].color = c_yellow
							break;
					}
				}
				display_log_message(logMessage)
				
				//Diplay effect message
				if results.isEffected {
					var effect_color = c_white
					//@TODO Add cases
					switch(results.effect){
						case "poison": effect_color = c_purple break;	
						case "burn": effect_color = c_orange break;	
						case "frozen": effect_color = c_aqua break;	
					}
					
					var effectMessage = {
						text:[
							{text: action.targetID.combatName, color: action.targetID.combatLogColor},
							{text: " was effected by ", color: c_white},
							{text: results.effect, color: effect_color}
						],
						color: c_white,
						frames: 90, //How many frames message is on screen
						alpha: 1
					}
					display_log_message(effectMessage)
				}
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
				else if string_lower(targets[0]) == "all players"{
					for (var i=0; i<array_length(combatants); i++){
						if object_get_parent(combatants[i].object_index) == obj_combat_party_member{
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
	#endregion
	#region Running Animation
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
		#endregion
	#region Check for dead
		case "Bring our yer dead":
		//Check for anyone below 0HP.
			for (var i=0;i<array_length(combatants);i++;){
				if combatants[i].currentHp <= 0 && combatants[i].isConscious{
					combatants[i].isConscious = false;
					combatants[i].currentHp = 0;
					var deathMessage = [
						{text: combatants[i].combatName, color: combatants[i].combatLogColor},
						{text: "has been defeated.", color: c_white},
						]
					deathMessage = {
						text:  deathMessage,	
						color: c_white,
						frames: 90, //How many frames message is on screen
						alpha: 1
					}
					display_log_message(deathMessage)
				}
					//array_copy(global.COMBATANTS, -1, canStillGo, 0, array_length(canStillGo))
			}
		
		
			//We could toy around with being unconcious but having HP means you may wake up.
			//If so, animate death/down.
				//@TODO Figure out how to do this. 
				//Probably setting the sprite to a death animation then a speed/index to do the last frame.
		
		
			activeCombatant.image_xscale = originalScaleX; //Seemed like the best place to put this I guess.
			activeCombatant.image_yscale = originalScaleY;
		
		
			step = "Run conditions";
		break;
	#endregion
	#region Run conditions
		case "Run conditions":
		print("statuses v")
			for (var i=0;i<array_length(activeCombatant.statusEffects);i++;){
				if activeCombatant.statusEffects[i].value == true{
					action = global.STATUS_ATTACKS[$ activeCombatant.statusEffects[i].name]
					doAction(activeCombatant)
				}
			}
			step = "Reset check";
		break;
	#endregion
	#region Reset Check
		case "Reset check":
		//Check if everyone has gone,
			var resetCycle = false;
			var readyForNextRound = 0
			for (var i=0;i<array_length(combatants);i++;){
				if combatants[i].hasActed == true || !combatants[i].isConscious{
					readyForNextRound++;
					if readyForNextRound == array_length(combatants){
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
	#endregion
}else{
	waitFrames--
}
#endregion
