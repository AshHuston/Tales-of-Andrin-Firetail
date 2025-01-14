event_inherited()


function generateLoot(){
	var loot = []
	// @TODO Figure out how to generate loot from mob to mob	
	loot = [
		{name: "gold", quantity: round(random(25)), sprite: spr_gold_coins},
		{name: "Zombie brain", quantity: round(random(10)), itemInfo: {
			name: "", 
			quantity: 0, 
			use: function healUser(targetID){
				var healAmt = round(random_range(5, 10));
				targetID.currentHP += healAmt;
				return {animation_index: "None", hpRestored: healAmt};
			   	}, 
			description:"Heals user for 5-10 HP", 
			canTarget:"self",
			actionType:"item",
			combatMenu:true,
			targetID:"",
			bonus_targetID: "",
			animation_index: "None"
		
			}, sprite: spr_zombie_brain}
		] // Completley arbitrary. For testing.
	return cleanUpLoot(loot)
}

periodicallyFlip(60)

if !hasStartedCombat && place_meeting(x, y, obj_overworld_aaron){
	hasStartedCombat = true
	var numberOfMobs = 1
	startCombat(numberOfMobs, obj_combat_boss_rat)
	lootForCombat = generateLoot()
}
