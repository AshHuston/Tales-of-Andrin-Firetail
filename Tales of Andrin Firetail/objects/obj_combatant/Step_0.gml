var defaultSprite = sprite_index;
var damageAnimationSprite = defaultSprite;	//Will need to be changed to the dmg one


if isTakingDamage{
	sprite_index = damageAnimationSprite;
	if round(image_index) == image_number-1{
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

if !isConscious && !isTakingDamage{
	image_index = 0	
	image_angle = 270
}

if sprite_get_name(sprite_index) != defaultSpriteName && image_index >= sprite_get_number(sprite_index)-1.5{
	sprite_index = asset_get_index(defaultSpriteName)
}
