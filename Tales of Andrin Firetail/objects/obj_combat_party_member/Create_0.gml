baseHP = associatedCharacterID.HP;
baseSpeed = associatedCharacterID.combatSpeed;
baseArmor = associatedCharacterID.armor;
baseMagicResist = associatedCharacterID.magicResist;

skillRanged = associatedCharacterID.skillRanged;
skillMelee = associatedCharacterID.skillMelee;
skillEdged = associatedCharacterID.skillEdged;
skillMagic = associatedCharacterID.skillMagic;



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


attacks = [];
	//@TODO Add a for loop adding attacks. Attacks should be a struct detailing at minimum, 'Name', 'damage', and "hitChance'.


inventory = []; // [Item][quantity]
	//@TODO Add a for loop adding items marked 'combat' to the list. Items should be a struct detailing at minimum, 'Name' and 'Quantity'.


spells = [];
	//@TODO Add a for loop adding spells. Spells should be a struct detailing at minimum, 'Name' and other important spell stuff.

specialActions = []; //@TODO Special action names. Will figure this out later.


	//Print values to test



/// @function                 getItemBonus(stat);
/// @param {String}	stat	  The stat to get.
/// @description			  Returns an INT of the total bonus for the chosen stat from items in the scope of the calling obj_combat_party_member.
/// @return {Real}			  Returns sum.
function getItemBonus(stat){
	//@TODO Returns the sum item bonuses of the passed stat.
	
}

/// @function                 getEffectBonus(stat);
/// @param {String}	stat	  The stat to get.
/// @description			  Returns an INT of the total bonus for the chosen stat from effects in the scope of the calling obj_combat_party_member.
/// @return {Real}			  Returns sum.
function getEffectBonus(stat){
	//@TODO Returns the sum item bonuses of the passed stat.	
}