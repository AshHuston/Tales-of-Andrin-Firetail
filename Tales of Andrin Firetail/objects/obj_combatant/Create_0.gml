// Struct should contain: targetID, bonus_targetID, dmg_type, min_dmg, max_dmg, hit_chance, effect_chance, effect_type. 

/// @function                 attack(details);
/// @param {struct}	details	  The details to be interpreted by the combat system.
/// @description              Runs the attack. Calculating if hit, adjusting target HP, applying effects, etc.
function attack(details){
//Ensure struct elements are present
	//@TODO Insert try catch block checking it and returning an error if something is missing.	
	
	
	
//Grabs appropriate defense stat from the target
	var defenseStat = 0
	if dmg_type == "magic"{
		defenseStat = details.target_id.magic_resistence;
	}
	if dmg_type == "physical"{
		defenseStat = details.target_id.armor;
	}
	
//Check if effect will apply.
	//Check if target is resistant.
	var resistant = false
	if string_pos(details.dmg_type, details.target.resistances) != 0 {resistant = true}
	
	//Check if target is immune.
	var immune = false
	if string_pos(details.dmg_type, details.target.immunities) != 0 {immune = true}
	
	//Adjust the chance.
	var effectPercent = effect_chance
	if immune{effectPercent -= 100}
	if resistant{effectPercent -= 50}
	if random_range(1, 100) <= effectPercent{
		//Apply the effect to the target
		details.target.statusEffect += (" "+ details.effect_type);
	}
	
//Checks if attack hits
	var hitPercent = details.hit_chance - defenseStat;
	if random_range(0, 100) <= hitPercent{
		//@TODO Resolve the hit.
	}

//Apply attack to the bonus target.
	//Adjust targets.
	bonusHitDetails = {
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
	attack(bonusHitDetails);
}