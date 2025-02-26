hasActed = false;
isActive = false;
isConscious = true;
statusEffects = [];
isTakingDamage = false;
startedDamageSFX = false;
damageSoundEffect = snd_no_sound
damageAnimationCounter = 0;
defaultSprite = sprite_index;
damageAnimationSprite = defaultSprite;	//Will need to be changed to the dmg one
combatName = "UNNAMED COMBATANT"
combatLogColor = c_white
secondaryDisplayBar = "none"
//DisplayStats 
secondaryDisplayBarMax = 0
secondaryDisplayBarCurrent = 0

/// @function                 attack(details);
/// @param {struct}	details	  The details to be interpreted by the combat system.
/// @description              Runs the attack. Calculating if hit, adjusting target Hp, applying effects, etc.
function attack(details){
// Struct should contain: targetID, bonus_targetID, dmg_type, min_dmg, max_dmg, hit_chance, effect_chance, effect_type. 	
#region Ensure struct elements are present
	// @TODO Varify the details struct has everything it needs.
	var defaultVals = {
		crit_chance_percent : 5,
		crit_dmg_mod : 1.5
	}
	if !variable_struct_exists(details, "crit_chance_percent"){details.crit_chance_percent = defaultVals.crit_chance_percent}
	if !variable_struct_exists(details, "crit_dmg_mod"){details.crit_dmg_mod = defaultVals.crit_dmg_mod}
#endregion
	
#region Defense stat
	var target = details.targetID;
	var defenseStat = 0
	if details.dmg_type == "magic"{
		defenseStat = target.totalMagicResist;
	}
	if details.dmg_type == "physical"{
		defenseStat = target.totalArmor;
	}
#endregion

#region Effects
	var resistant = false
	var immune = false
	var isEffected = false;
	if string_pos(details.dmg_type, target.resistances) != 0 {resistant = true}
	if string_pos(details.dmg_type, target.immunities) != 0 {immune = true}
	var effectPercent = details.effect_chance;
	if immune{effectPercent -= 100;}
	if resistant{effectPercent -= 50;}
	if random_range(1, 100) <= effectPercent{
		isEffected = true;
	}
#endregion

#region Hit calculation
	var results = {
		mainDmg:0, 
		mainType:"", 
		secondaryDmg:0, 
		secondaryType:"", 
		hit: false, 
		animation_index: details.animation_index, 
		effect: "", 
		isEffected: false,
		isCrit: false,
		logMessage:[{text: "DEFAULT LOG MESSAGE - ATTACK", color: c_white}],
		};
	if variable_struct_exists(details, "logMessage"){
		results.logMessage = details.logMessage
	}
	
	var hitPercent = details.hit_chance - target.totalEvasion;
	var minmumPossibleHitPercent = 2;
	if hitPercent < minmumPossibleHitPercent{
		hitPercent = minmumPossibleHitPercent;
	}
	
	if round(random_range(0, 100)) <= details.crit_chance_percent{ results.isCrit = true }
	
	if round(random_range(0, 100)) <= hitPercent{ // Attack hits		
		var dmg = random_range(details.min_dmg, details.max_dmg);
		
		//Apply armor/magic-resist
		defenseStat = defenseStat*random_range(0.90, 1.10);
		dmg = dmg - (dmg*defenseStat)/100;
		if round(random_range(0, 100)) <= results.isCrit{ dmg *= details.crit_dmg_mod }
		dmg = round(dmg)
		
		details.targetID.currentHp -= dmg;
		results.mainDmg = dmg;
		results.mainType = details.dmg_type;
		results.hit = true;
		
		if isEffected{
			print("effected")
			var statusEffect = {name: details.effect_type, value: true}
			if !array_contains(target.statusEffects, statusEffect){ //@TODO Currently fails to notice the valiue is already there.
				array_push(target.statusEffects, statusEffect);
				results.isEffected = true;
				results.effect = details.effect_type;
			}
		}
	}
	else{
		results.mainDmg = -1;
		results.logMessage =[
		{text: "*ACTIVE", color: c_aqua},
		{text: "missed", color: c_white},
		{text: "*TARGET", color: c_olive}
		]
	}
#endregion

#region Bonus target
	if details.bonus_targetID != ""{
		var bonusHitDetails = {
			targetID: details.bonus_targetID, 
			bonus_targetID: "", 
			dmg_type: details.dmg_type, 
			min_dmg: details.min_dmg, 
			max_dmg: details.max_dmg, 
			hit_chance: details.hit_chance, 
			effect_chance: details.effect_chance, 
			effect_type: details.effect_type,
			crit_chance_percent : details.crit_chance_percent,
			crit_dmg_mod : details.crit_dmg_mod,
		}
		var secondaryAttack = attack(bonusHitDetails);
		results.secondaryDmg = secondaryAttack.mainDmg;
		results.secondaryType = secondaryAttack.mainType;
	}
	return results;
}
#endregion

function castSpell(details){
	if details.spellType == "attack"{
		return attack(details)
	}else{
		//@TODO Figure this out	
		splash_text("Spells only work as attacks lol. Go to obj_combatatant create ln:144")
	}
}

function useItem(details){
	var result;
	if details.targetID == "self"{
		result = details.use(self, details.bonus_targetID);	
	}
	else{
		result = details.use(targetID, details.bonus_targetID);	
	}
	if !variable_struct_exists(results, "logMessage"){ results.logMessage = [{text: "DEFAULT LOG MESSAGE - ITEM", color: c_white}]}
	return result;
}

function doAction(detailStruct){
	switch(detailStruct.actionType){
	case "attack":
		return attack(detailStruct);
	
	case "spell":
		return castSpell(detailStruct);
		break;
	
	case "item":
		return useItem(detailStruct);
	
	case "special":
		useSpecialAction(detailStruct);
		break;
	}
}
	
function spendResource(details){
	switch(details.actionType){
		case "spell": secondaryDisplayBarCurrent -= details.cost_value break;	
	}
}