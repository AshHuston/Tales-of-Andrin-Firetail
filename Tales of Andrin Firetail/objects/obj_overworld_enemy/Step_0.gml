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
			loot[i].itemInfo.name = loot[i].name
			loot[i].itemInfo.quantity = loot[i].quantity
		}
	}
	return loot
}

function startCombat(numberOfMonsters, certainMonsters, possibleMonsters=[]){
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

if hasStartedCombat && !instance_exists(obj_combatFadeIn){
	x = global.DEFAULT_OVERWORLD_MONSTER_BENCH[0]
	y = global.DEFAULT_OVERWORLD_MONSTER_BENCH[1]
	benchThisMonster()
	instance_create_depth(0,0,0,obj_combat_manager, {
		overworld_mob:id, 
		lootToDrop: lootForCombat,
		mob1: mobs[0], 
		mob2: mobs[1], 
		mob3: mobs[2], 
		mob4: mobs[3], 
		mob5: mobs[4], 
		})
}
	
	