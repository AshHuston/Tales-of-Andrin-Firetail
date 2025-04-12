event_inherited()

function generateLoot(){
	var loot = []
	// @TODO Figure out how to generate loot from mob to mob	
	loot = [
		{name: "gold", quantity: round(random(10)), sprite: spr_gold_coins},
		{name: "Rat Brain", quantity: round(random(2)), sprite: spr_zombie_brain, itemInfo: {
			name:"Rat Brain", 
			quantity: round(random(1)),
			stackable: true,
			menuPage: "consumables",
			can_use: function canHealUser(targetID){return (targetID.currentHp < targetID.maxHp)},
			use: function healUser(targetID){
				var healAmt = round(random(5))+5;
				var startHp = targetID.currentHp
				targetID.currentHp += healAmt;
				if targetID.currentHp > targetID.maxHp{targetID.currentHp = targetID.maxHp}
				healAmt = targetID.currentHp - startHp
				return {animation_index: "None", hpRestored: healAmt, can_use:(startHp < targetID.maxHp)};
			   	}, 
			description:"Heals user for 5-10 HP", 
			canTarget:"party member",
			actionType:"item",
			combatMenu:true,
			targetID:"",
			bonus_targetID: "",
			animation_index: "None"
		
			}}
		] // Completley arbitrary. For testing.
	return cleanUpLoot(loot)
}

periodicallyFlip(60)

if !hasStartedCombat && place_meeting(x, y, obj_overworld_aaron){
	hasStartedCombat = true
	var quantities = [1, 1, 1, 2, 2, 2, 2, 2, 3] //@TESTING One way to get a number of mobs
	var numberOfMobs = array_shuffle(quantities)[0]
	if mobsNumOverride > 0{numberOfMobs = mobsNumOverride}
	startCombat(numberOfMobs, obj_combat_rat)
	lootForCombat = generateLoot()
}