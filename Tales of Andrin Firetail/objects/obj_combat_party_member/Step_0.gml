// Inherit the parent event
/// @description Testing only. Delete later
event_inherited();
bite = {
	display_name: "bite",	//Only really needed for playable characters. Will show up on menu.
	description: "bites at target. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 27, 
	max_dmg: 70, 
	hit_chance: 75, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: 5
};
bite.targetID = instance_find(obj_enemy, 0);

attacks = [bite];


//-------------TESTS ONLY -> DELETE LATER-------------------
//var results = inventory[0].use(self);
