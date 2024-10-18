event_inherited()

function generateLoot(){
	var loot = {}
	// @TODO Figure out how to generate loot from mob to mob	
	loot = {
		gold: round(random(25)),
		zombie_brain: round(random(1))
		} // Completley arbitrary. For testing.
	return loot
}

periodicallyFlip(60)

if !hasStartedCombat && place_meeting(x, y, obj_overworld_aaron){
	hasStartedCombat = true
	var quantities = [1, 1, 1, 2, 2, 2, 2, 2, 3] //@TESTING One way to get a number of zombies
	var numberOfMobs = array_shuffle(quantities)[0]
	numberOfMobs = 3 //@TESTING Overriding the random number of zombies
	startCombat(numberOfMobs, obj_combat_zombie)
	lootForCombat = generateLoot()
}
