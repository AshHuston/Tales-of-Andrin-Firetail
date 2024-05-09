// Inherit the parent event
/// @description Testing only. Delete later
event_inherited();
bite = {
	name: "bite",	//Only really needed for playable characters. Will show up on menu.
	description: "bites at target. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 7, 
	max_dmg: 20, 
	hit_chance: 95, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: 5,
	actionType: "attack",
	animation_index: spr_test_attack_claw
};


shoot = {
	name: "Shoot",	//Only really needed for playable characters. Will show up on menu.
	description: "Shoots at target.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 100, 
	max_dmg: 130, 
	hit_chance: 75, 
	effect_chance: 0, 
	effect_type: "",
	frequency: 5,
	actionType: "attack",
	animation_index: spr_test_attack_flame
};

attacks = [bite, shoot];


//-------------TESTS ONLY -> DELETE LATER-------------------
//var results = inventory[0].use(self);
