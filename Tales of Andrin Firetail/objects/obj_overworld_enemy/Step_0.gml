function periodicallyFlip(oneInXFrames=75){
	var num
	num = random(oneInXFrames)
	if num <=1{ image_xscale*=-1 }
}

function benchThisMonster(){
	x = global.DEFAULT_OVERWORLD_MONSTER_BENCH[0]
	y = global.DEFAULT_OVERWORLD_MONSTER_BENCH[1]
	hasStartedCombat = false
}

function generateLoot(){
	var loot = {}
	// @TODO Figure out how to generate loot from mob to mob. This method should usually be overridden.
	loot = {gold: 13} //@TESTING Completley arbitrary. For testing.
	return loot
}

function cleanUpLoot(loot){
	for (var i = 0; i<array_length(loot); i++){
		if variable_struct_exists(loot[i], "itemInfo"){
			if loot[i].quantity > 0 {
				loot[i].itemInfo.name = loot[i].name
				loot[i].itemInfo.quantity = loot[i].quantity 
			}else{ array_delete(loot, i, 1) }
		}
	}
	return loot
}

function addTutorialCombat(){
	if false == getFlag("demo.combatTutorialFinished"){
		var combatTutorial = {
		completed: false,
		waitFrames: 25,
		trigger: {
			type: "round", 
			goal: 1, 
			targetVal: "round_counter"
			},
		content: {
			eventType: "dialogue",
			pauseCombat: true,
			content: getDialogue("DEMO 3")
			}
		}
		var logToggleMessage = {
			completed: false,
			waitFrames: 15,
			trigger: {
				type: "round", 
				goal: 2, 
				targetVal: "round_counter"
				},
			content: {
				eventType: "popup",
				pauseCombat: true,
				content: "Press Y to toggle the full combat log."
				}
		}
		//var logButton = "Y"
		//if gamepad_is_connected(0){logToggleMessage.content.content = "Press "+logButton+" to toggle the full combat log."}
		array_push(combatSpecialEvents, combatTutorial, logToggleMessage)	
		setFlag("demo.combatTutorialFinished", true)
	}
}

function startCombat(numberOfMonsters, certainMonsters, possibleMonsters=[]){
	setFlag("general.isInCombat", true)
	if !instance_exists(obj_combat_manager) && !instance_exists(obj_combat_cleanup){
		addTutorialCombat() //Not really sure the best place to put this... It doesnt really belong here i feel.
		numberOfMonsters = clamp(numberOfMonsters, 1, 5)
		if typeof(certainMonsters) != "array" {certainMonsters = [certainMonsters]}
		if array_length(possibleMonsters) == 0 {array_copy(possibleMonsters, 0, certainMonsters, 0, array_length(certainMonsters))}
		for (var i = 0; i<numberOfMonsters; i++){
			if i<array_length(certainMonsters){
				mobs[i] = instance_create_depth(0,0,0,certainMonsters[i])
			}else{
				possibleMonsters = array_shuffle(possibleMonsters)
				mobs[i] = instance_create_depth(0,0,0,possibleMonsters[0])
			}
		}
		instance_create_depth(x, y, 0, obj_combatFadeIn)
	}
}

// This kinda sucks because the movement is different than the player's movement. But tbh I think imma change the player mvmnt anyway so idk.
function stepTowards(targetID, range = 2147483647, stepSpeed = 1){
	if typeof(targetID) == "ref"{
		targetID = {
			x: targetID.x,
			y: targetID.y
		}
	}
	
	var isHomeLocation = false
	if targetID.x == homeLocation.x && targetID.y == homeLocation.y {isHomeLocation = true}
	if framesLeftInAggroCooldown>0 {framesLeftInAggroCooldown--;}
	var moved = false
	
	if point_distance(x, y, targetID.x, targetID.y) <= range{
		if targetID.x > x { x += stepSpeed; image_xscale = -1; moved = true }
		else if x > targetID.x {x -= stepSpeed; image_xscale = 1; moved = true }
		if targetID.y > y { y += stepSpeed; moved = true }
		else if y > targetID.y {y -= stepSpeed; moved = true }
	}
	if moved && !isHomeLocation {framesLeftInAggroCooldown = maxWaitFrames}
}

if hasStartedCombat && !instance_exists(obj_combatFadeIn) && !instance_exists(obj_combat_manager) && !instance_exists(obj_combat_cleanup){
	benchThisMonster()
	instance_create_depth(0,0,0,obj_combat_manager, {
		overworld_mob:id, 
		lootToDrop: lootForCombat,
		mob1: mobs[0], 
		mob2: mobs[1], 
		mob3: mobs[2], 
		mob4: mobs[3], 
		mob5: mobs[4],
		specialEvents: combatSpecialEvents
		})
}
	
if chasePlayer && !global.GAME_IS_PAUSED{ 
	stepTowards(global.OVERWORLD_ID_AARON, 75)
	if framesLeftInAggroCooldown<=0 && !(x == homeLocation.x && y == homeLocation.y){stepTowards(homeLocation);}
}