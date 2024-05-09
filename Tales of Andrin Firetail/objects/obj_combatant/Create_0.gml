hasActed = false;
isActive = false;
inConscious = true;
statusEffects = [];
isTakingDamage = false;
damageAnimationCounter = 0;
defaultSprite = sprite_index;
damageAnimationSprite = defaultSprite;	//Will need to be changed to the dmg one

/// @function                 attack(details);
/// @param {struct}	details	  The details to be interpreted by the combat system.
/// @description              Runs the attack. Calculating if hit, adjusting target HP, applying effects, etc.
function attack(details){
// Struct should contain: targetID, bonus_targetID, dmg_type, min_dmg, max_dmg, hit_chance, effect_chance, effect_type. 	
//Ensure struct elements are present

	//@TODO Insert try catch block checking it and returning an error if something is missing.	
	
	
	var target = details.targetID;
	//show_message(target);
//Grabs appropriate defense stat from the target
	var defenseStat = 0
	if details.dmg_type == "magic"{
		defenseStat = target.magic_resistence;
	}
	if details.dmg_type == "physical"{
		defenseStat = target.totalArmor;
	}
	
//Check if effect will apply.
	//Check if target is resistant.
	var resistant = false
	if string_pos(details.dmg_type, target.resistances) != 0 {resistant = true}
	
	//Check if target is immune.
	var immune = false
	if string_pos(details.dmg_type, target.immunities) != 0 {immune = true}
	
	//Adjust the chance.
	var effectPercent = details.effect_chance;
	var isEffected = false;
	if immune{effectPercent -= 100;}
	if resistant{effectPercent -= 50;}
	if random_range(1, 100) <= effectPercent{
		isEffected = true;
	}
	
//Checks if attack hits. If so, resolve the attack.
	var results = {mainDmg:0, mainType:"", secondaryDmg:0, secondaryType:"", hit: false, animation_index: details.animation_index, effect: "", isEffected: false};
	var hitPercent = details.hit_chance - defenseStat;
	if random_range(0, 100) <= hitPercent{
		//Determine damage
		var dmg = random_range(details.min_dmg, details.max_dmg);
		dmg = round(dmg)
		//Apply damage
		details.targetID.currentHP -= dmg;
		results.mainDmg = dmg;
		results.mainType = details.dmg_type;
		results.hit = true;
		
		//If effected, apply effect.
		if isEffected{
			//Apply the effect to the target
			array_push(target.activeEffects, {name: details.effect_type, value: true});
			show_debug_message(target.combat_name + " effected with " + details.effect_type)
			results.isEffected = true;
			results.effect = details.effect_type;
		}
	}else{results.mainDmg = -1;}

//Apply attack to the bonus target.
	if details.bonus_targetID != ""{
		
		//Adjust targets.
		var bonusHitDetails = {
			targetID: details.bonus_targetID, 
			bonus_targetID: "", 
			dmg_type: details.dmg_type, 
			min_dmg: details.min_dmg, 
			max_dmg: details.max_dmg, 
			hit_chance: details.hit_chance, 
			effect_chance: details.effect_chance, 
			effect_type: details.effect_type
		}
		
		//Recur the function for the bonus hit.
		var secondaryAttack = attack(bonusHitDetails);
		results.secondaryDmg = secondaryAttack.mainDmg;
		results.secondaryType = secondaryAttack.mainType;
	}
	return results;
}

function useItem(details){
	var result;
	if details.targetID == "self"{
		result = details.use(self, details.bonus_targetID);	
	}
	else{
		result = details.use(targetID, details.bonus_targetID);	
	}
	return result;
}

function doAction(detailStruct){
	switch(detailStruct.actionType){
	case "attack":
		return attack(detailStruct);
		break;
	
	case "spell":
		castSpell(detailStruct);
		break;
	
	case "item":
		return useItem(detailStruct);
		break;
	
	case "special":
		useSpecialAction(detailStruct);
		break;
	}
}