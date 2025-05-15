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
		dmg_type: "slashing", 
		min_dmg: 5, 
		max_dmg: 12, 
		hit_chance: 90, 
		actionType: "attack",
		soundEffectId: snd_swipe,
		animation_index: spr_test_attack_flame, //@TODO Add slashing animation
		bonus_targetID: "",
		logMessage: [
			{text: "*ACTIVE", color: c_aqua},
			{text: "cleaves", color: c_white},
			{text: "*TARGET", color: c_olive},
			{text: "with longsword, dealing", color: c_white},
			{text: "*DAMAGE", color: c_white},
			{text: "damage.", color: c_white},
			]
		}
}