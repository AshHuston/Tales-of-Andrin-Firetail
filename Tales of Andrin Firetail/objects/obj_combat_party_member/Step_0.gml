// Inherit the parent event
/// @description Testing only. Delete later
event_inherited();
var bite = {
	name: "Bite",	//Only really needed for playable characters. Will show up on menu.
	description: "bites at target. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 2, 
	max_dmg: 6, 
	hit_chance: 95, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: 5,
	actionType: "attack",
	animation_index: spr_test_attack_claw,
	logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "bites", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
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
	animation_index: spr_test_attack_claw,
	logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "stabs", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
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
	animation_index: spr_test_attack_flame,
	logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "slashes", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
};

var kill = {
	name: "INSTAKILL",	//Only really needed for playable characters. Will show up on menu.
	description: "Shoots at target.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 9999, 
	max_dmg: 9999, 
	hit_chance: 110, 
	effect_chance: 0, 
	effect_type: "",
	frequency: 5,
	actionType: "attack",
	animation_index: spr_test_attack_flame,
	logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "shoot", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
};

if addAttacks{ //Just for some test attacks, remove later. @TESTING
	addAttacks = false
	array_push(attacks, bite)
	//array_push(attacks, stab)
	array_push(attacks, kill)
	//array_push(attacks, slash)
}