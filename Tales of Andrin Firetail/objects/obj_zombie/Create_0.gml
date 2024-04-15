HP = 25;
statusEffect = "";
resistances = "";
immunities = "poison tired";
armor = 3;
magicResist = 1;

// Inherit the parent event
event_inherited();

swipe = {
	display_name: "Swipe",	//Only really needed for playable characters. Will show up on menu.
	description: "Swpies at target with claws. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 2, 
	max_dmg: 6, 
	hit_chance: 90, 
	effect_chance: 10, 
	effect_type: "poison",
	frequency: 10	//@TODO Figure out what kind of frequency numbers actually make sense.
}

bite = {
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 3, 
	max_dmg: 4, 
	hit_chance: 75, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: 5
}

attacks = [swipe, bite]