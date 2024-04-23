// Inherit the parent event
/// @description Testing only. Delete later
event_inherited();
bite = {
	name: "bite",	//Only really needed for playable characters. Will show up on menu.
	description: "bites at target. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 27, 
	max_dmg: 70, 
	hit_chance: 75, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: 5,
	actionType: "attack"
};
bite.targetID = instance_find(obj_enemy, 0);

shoot = {
	name: "Shoot",	//Only really needed for playable characters. Will show up on menu.
	description: "Shoots at target.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 100, 
	max_dmg: 130, 
	hit_chance: 55, 
	effect_chance: 0, 
	effect_type: "",
	frequency: 5,
	actionType: "attack"
};
shoot.targetID = instance_find(obj_enemy, 0);

attacks = [bite, shoot];


//-------------TESTS ONLY -> DELETE LATER-------------------
//var results = inventory[0].use(self);
