event_inherited()

itemInfo = {
	name : "Incinerate",
	sprite : spr_crystal_6,
	coords: [6,0],
	slave_cells: [[1,1], [2,0]],
	other_filled_slots: [], //Left intentionally empty
	effectType: "spell",
	effect: {
		name: "Incinerate",	//Only really needed for playable characters. Will show up on menu.
		description: "Casts fire at all enemies, may burn.",	//Only really needed for playable characters. Will show up on menu.
		targetID: "all enemies", //Should be "all", "all enemies", or whatever the combat system's equivilent is.
		bonus_targetID: "", 
		dmg_type: "fire", 
		min_dmg: 3, 
		max_dmg: 7, 
		hit_chance: 85, 
		effect_chance: 0, //@TODO addthis later
		effect_type: "burn",
		combatMenu: true,
		actionType: "spell",
		spellType: "attack",
		animation_index: spr_test_attack_flame,
		cost_type: "MP",
		cost_value: 20,
		logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "burns", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
	}
}