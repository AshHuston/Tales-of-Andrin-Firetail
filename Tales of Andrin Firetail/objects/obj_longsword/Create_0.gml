event_inherited()

itemInfo = {
	name: "Longsword",
	skillType: "melee",
	menuPage: "equipment",
	tags:["weapon"],
	attack: {
		name: "Longsword",	//Only really needed for playable characters. Will show up on menu.
		description: "slices target.",	//Only really needed for playable characters. Will show up on menu.
		targetID: "", 
		bonus_targetID: "", 
		dmg_type: "magic", 
		min_dmg: 5, 
		max_dmg: 12, 
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
		}
}