event_inherited()

itemInfo = {
	name : "Incinerate",
	sprite : spr_crystal_2,
	coords: [6,0],
	slave_cells: [[1,1], [2,0]],
	other_filled_slots: [], //Left intentionally empty
	effectType: "attack",
	effect: {
		name: "Incinerate",	//Only really needed for playable characters. Will show up on menu.
		description: "Burns all enemies",	//Only really needed for playable characters. Will show up on menu.
		targetID: "all enemies", //Should be "all", "all enemies", or whatever the combat system wants that to be.
		bonus_targetID: "", 
		dmg_type: "fire", 
		min_dmg: 10, 
		max_dmg: 30, 
		hit_chance: 85, 
		effect_chance: 0, 
		effect_type: "",
		frequency: 5,
		actionType: "attack",
		animation_index: spr_test_attack_flame
	}
}