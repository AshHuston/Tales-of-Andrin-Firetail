global.STATUS_ATTACKS = {
	poison: {
		display_name: "Poison",
		description: "",
		targetID: "", 
		bonus_targetID: "", 
		dmg_type: "poison", 
		min_dmg: 4, 
		max_dmg: 8, 
		hit_chance: 100, 
		effect_chance: 0, 
		effect_type: "",
		actionType: "attack",
		animation_index: spr_test_attack_poison,
		logMessage: [
			{text: "*ACTIVE", color: c_aqua},
			{text: "is hurt by their", color: c_white},
			{text: "poison.", color: c_purple},
			]
		},
	burn: {
		display_name: "Burn",
		description: "",
		targetID: "", 
		bonus_targetID: "", 
		dmg_type: "fire", 
		min_dmg: 6, 
		max_dmg: 10, 
		hit_chance: 100, 
		effect_chance: 0, 
		effect_type: "",
		actionType: "attack",
		animation_index: spr_test_attack_flame,
		logMessage: [
			{text: "*ACTIVE", color: c_aqua},
			{text: "is hurt by their", color: c_white},
			{text: "burn.", color: c_orange},
			]
		},
	
}