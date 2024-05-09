if isTakingDamage{
	sprite_index = damageAnimationSprite;
	if image_index == image_number-1{
		sprite_index = defaultSprite;
		isTakingDamage = false;
	}
}