baseHP = round(random_range(45,75));
currentHP = baseHP;
statusEffect = [];
resistances = ["physical", "poison"];
immunities = ["poison", "tired"];
totalArmor = round(random_range(3,4));
totalMagicResist = 1;
totalSpeed = round(random_range(10, 13));
// Inherit the parent event
event_inherited();

swipe = {
	display_name: "Swipe",
	description: "Swpies at target with claws. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 2, 
	max_dmg: 6, 
	hit_chance: 90, 
	effect_chance: 10, 
	effect_type: "poison",
	frequency: round(random_range(8,12)),	//@TODO Figure out what kind of frequency numbers actually make sense.
	actionType:"attack"
}

bite = {
	display_name: "bite",
	name: "bite",
	description: "bites at target. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 3, 
	max_dmg: 4, 
	hit_chance: 90, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: round(random_range(4,8)),
	actionType:"attack",
	animation_index: spr_test_attack_claw
}

attacks = [swipe, bite]

function getAction(){
	//Pick target
	var partyIDs = []
		partyIDs = getCombatPartyIDs();
	//var targetIndex = round(random_range(0,array_length(partyIDs)));
	var targetIndex = 0;
	var target = partyIDs[targetIndex];
	
	// Pick attack
	bite.targetID = target;
	show_debug_message("Used " + bite.name + " targeting " + string(target.combat_name));
	return bite;
}


damageAnimationSprite = dmg_zombie_sprite;