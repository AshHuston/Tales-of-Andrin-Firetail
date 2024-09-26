// Inherit the parent event
/// @description Testing only. Delete later
event_inherited();
var bite = {
	name: "Bite",	//Only really needed for playable characters. Will show up on menu.
	description: "bites at target. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 12, 
	max_dmg: 18, 
	hit_chance: 95, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: 5,
	actionType: "attack",
	animation_index: spr_test_attack_claw
};

var stab = {
	name: "StabbyWabby",	//Only really needed for playable characters. Will show up on menu.
	description: "Pokes target.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 15, 
	max_dmg: 45, 
	hit_chance: 90, 
	effect_chance: 0, 
	effect_type: "",
	frequency: 5,
	actionType: "attack",
	animation_index: spr_test_attack_claw
};

var slash = {
	name: "Sword Slash",	//Only really needed for playable characters. Will show up on menu.
	description: "slices target.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "magic", 
	min_dmg: 20, 
	max_dmg: 20, 
	hit_chance: 90, 
	effect_chance: 0, 
	effect_type: "",
	frequency: 5,
	actionType: "attack",
	animation_index: spr_test_attack_flame
};

var shoot = {
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

if addAttacks{ //Just for some test attacks, remove later.
	addAttacks = false
	array_push(attacks, bite)
	array_push(attacks, stab)
	array_push(attacks, shoot)
	array_push(attacks, slash)
}
//-------------TESTS ONLY -> DELETE LATER-------------------
//var results = inventory[0].use(self);
