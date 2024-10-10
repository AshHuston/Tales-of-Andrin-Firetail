event_inherited()

combatName = "Aaron"
combatLogColor = c_aqua

damageSoundEffect = snd_agh

for(var i=0; i<array_length(global.EQUIPPED_CRYSTALS); i++){
	if global.EQUIPPED_CRYSTALS[i].effectType == "attack"{
		array_push(attacks, global.EQUIPPED_CRYSTALS[i].effect)
	}
	if global.EQUIPPED_CRYSTALS[i].effectType == "spell"{
		array_push(spells, global.EQUIPPED_CRYSTALS[i].effect)
	}
}

image_xscale = -1 //flip sprite the right way

