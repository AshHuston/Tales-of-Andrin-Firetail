baseHP = round(random_range(22,29));
currentHP = baseHP;
statusEffect = [];
resistances = ["physical", "poison"];
immunities = ["poison", "tired"];
armor = round(random_range(3,4));
magicResist = 1;

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
	frequency: round(random_range(8,12))	//@TODO Figure out what kind of frequency numbers actually make sense.
}

bite = {
	display_name: "bite",
	description: "bites at target. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 3, 
	max_dmg: 4, 
	hit_chance: 75, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: round(random_range(4,8))
}

attacks = [swipe, bite]