if isTakingDamage{
	sprite_index = damageAnimationSprite;
	if image_index == image_number-1{
		sprite_index = defaultSprite;
		isTakingDamage = false;
	}
	if startedDamageSFX == false{
		startedDamageSFX = true;
		//@TODO------------------------------------temporary removal for development QOL
		//audio_play_sound_ext({ sound: damageSoundEffect })
	}
}
else{
	startedDamageSFX = false;	
}

if !isConcious{
	image_index = 0	
}