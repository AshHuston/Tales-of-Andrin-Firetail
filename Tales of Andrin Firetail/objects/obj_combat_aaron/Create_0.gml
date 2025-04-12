event_inherited()

combatName = "Aaron"
combatLogColor = c_aqua
damageSoundEffect = snd_agh

#region EQ attacks/spells
for(var i=0; i<array_length(global.EQUIPPED_CRYSTALS); i++){
	if global.EQUIPPED_CRYSTALS[i].effectType == "attack"{
		array_push(attacks, global.EQUIPPED_CRYSTALS[i].effect)
	}
	if global.EQUIPPED_CRYSTALS[i].effectType == "spell"{
		array_push(spells, global.EQUIPPED_CRYSTALS[i].effect)
	}
}
#endregion
image_xscale = -1 //flip sprite the right way

var pistol = {
	name: "Pistol",	//Only really needed for playable characters. Will show up on menu.
	description: "Shoots the target.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 4, 
	max_dmg: 6, 
	hit_chance: 95, 
	effect_chance: 0, 
	effect_type: "",
	actionType: "attack",
	animation_index: spr_test_attack_claw, //@TODO Add a new animation for this
	soundEffectId: snd_musket,
	logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "shoots", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
};
array_push(attacks, pistol)