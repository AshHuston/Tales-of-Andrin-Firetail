event_inherited()
name = "Kylah"
setBaseStats()

combatName = "Kylah"
combatLogColor = c_olive
combatBaseSprite = sprite_index
combatDamageSprite = sprite_index

#region Spells
etherealBolt = {
		name: "Ethereal Bolt",
		description: "Shoots a bolt of magic at a target",
		targetID: "",
		bonus_targetID: "", 
		dmg_type: "Magic", 
		min_dmg: 5, 
		max_dmg: 6, 
		hit_chance: 90, 
		effect_chance: 0, 
		effect_type: "",
		combatMenu: true,
		actionType: "spell",
		spellType: "attack",
		animation_index: spr_test_attack_flame, //@TODO change spell animaton
		soundEffectId: snd_magic_bolt,
		cost_type: "MP",
		cost_value: 5,
		logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "casts a bolt at", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
	}

flameSplash = {
		name: "Flame Splash",
		description: "Slightly burns all enemies",
		targetID: "all enemies",
		bonus_targetID: "", 
		dmg_type: "fire", 
		min_dmg: 1, 
		max_dmg: 2, 
		hit_chance: 80, 
		effect_chance: 0, 
		effect_type: "",
		combatMenu: true,
		actionType: "spell",
		spellType: "attack",
		animation_index: spr_test_attack_flame,
		soundEffectId: snd_fire_spell,
		cost_type: "MP",
		cost_value: 10,
		logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "burns", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
	}
	
spells = [etherealBolt, flameSplash]