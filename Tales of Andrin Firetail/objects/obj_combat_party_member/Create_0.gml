event_inherited();

menuTexture = ""; //@TODO Add menu texture per character.

baseHP = associatedCharacterID.HP;
baseSpeed = associatedCharacterID.combatSpeed;
baseArmor = associatedCharacterID.armor;
baseMagicResist = associatedCharacterID.magicResist;

skillRanged = associatedCharacterID.skillRanged;
skillMelee = associatedCharacterID.skillMelee;
skillEdged = associatedCharacterID.skillEdged;
skillMagic = associatedCharacterID.skillMagic;

inventory = associatedCharacterID.inventory;
activeEffects = associatedCharacterID.activeEffects;

/// @function                 getItemBonus(stat);
/// @param {String}	stat	  The stat to get.
/// @description			  Returns an INT of the total bonus for the chosen stat from items in the scope of the calling obj_combat_party_member.
/// @return {Real}			  Returns sum.
function getItemBonus(stat){
	var key = "";
	switch(string_lower(stat)){
		case "armor":
			key = "bonusArmor" break;
		case "speed":
			key = "bonusSpeed" break;
		case "hp":
			key = "bonusHP" break;
		case "magic resist":
			key = "bonusMagicResist" break;
		default:
			show_error("No such stat '"+stat+"'", true)
			return 0;
	}
	var sum = 0;
	
	for(var i=0; i<array_length(inventory); i++;){
		if variable_struct_exists(inventory[i], key){
			switch(key){
				case "bonusArmor":
					sum += inventory[i].bonusArmor; break;
				case "bonusSpeed":
					sum += inventory[i].bonusSpeed; break;
				case "bonusHP":
					sum += inventory[i].bonusHP; break;
				case "bonusMagicResist":
					sum += inventory[i].bonusMagicResist; break;
			
			}
		}
	}
	return sum;
}

/// @function                 getEffectBonus(stat);
/// @param {String}	stat	  The stat to get.
/// @description			  Returns an INT of the total bonus for the chosen stat from effects in the scope of the calling obj_combat_party_member.
/// @return {Real}			  Returns sum.
function getEffectBonus(stat){
	var key = "";
	switch(string_lower(stat)){
		case "armor":
			key = "bonusArmor" break;
		case "speed":
			key = "bonusSpeed" break;
		case "hp":
			key = "bonusHP" break;
		case "magic resist":
			key = "bonusMagicResist" break;
		default:
			show_error("No such stat '"+stat+"'", true)
			return 0;
	}
	var sum = 0;
	
	for(var i=0; i<array_length(activeEffects); i++;){
		if variable_struct_exists(activeEffects[i], key){
			switch(key){
				case "bonusArmor":
					sum += activeEffects[i].bonusArmor; break;
				case "bonusSpeed":
					sum += activeEffects[i].bonusSpeed; break;
				case "bonusHP":
					sum += activeEffects[i].bonusHP; break;
				case "bonusMagicResist":
					sum += activeEffects[i].bonusMagicResist; break;
			
			}
		}
	}
	return sum;
}



itemBonusHP = getItemBonus("hp");
itemBonusSpeed = getItemBonus("speed");
itemBonusArmor = getItemBonus("armor");
itemBonusMagicResist = getItemBonus("magic resist");

effectBonusHP = getEffectBonus("hp");
effectBonusSpeed = getEffectBonus("speed");
effectBonusArmor = getEffectBonus("armor");
effectBonusMagicResist = getEffectBonus("magic resist");

totalHP = baseHP + itemBonusHP + effectBonusHP;
totalSpeed = baseSpeed + itemBonusSpeed + effectBonusSpeed;
totalArmor = baseArmor + itemBonusArmor+ effectBonusArmor;
totalMagicResist = baseMagicResist + itemBonusMagicResist + effectBonusMagicResist;

currentHP = totalHP;



attacks = [];
	//@TODO Add a for loop adding attacks. Attacks should be a struct detailing at minimum, 'Name', 'damage', and "hitChance'.

spells = [];
	//@TODO Add a for loop adding spells. Spells should be a struct detailing at minimum, 'Name' and other important spell stuff.

specialActions = []; //@TODO Special action names. Will figure this out later.
