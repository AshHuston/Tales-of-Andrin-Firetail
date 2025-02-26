///@description

event_inherited();

addAttacks = true //Just for some test attacks, remove later.

sprite_index = associatedCharacterID.combatBaseSprite
combatName = associatedCharacterID.combatName
combatLogColor = associatedCharacterID.combatLogColor 
secondaryDisplayBar = associatedCharacterID.secondaryDisplayBar
secondaryDisplayBarMax = associatedCharacterID.secondaryDisplayBarMax
secondaryDisplayBarCurrent = associatedCharacterID.secondaryDisplayBarCurrent

damageAnimationSprite = sprite_index;
try{
	damageAnimationSprite = associatedCharacterID.combatDamageSprite	
}

menuTexture = ""; //@TODO Add menu texture per character.

baseStats = {
	hp: associatedCharacterID.maxHp,
	spd: associatedCharacterID.combatSpeed,
	armor: associatedCharacterID.armor,
	magicResist: associatedCharacterID.magicResist,
	evasion: associatedCharacterID.evasion,
}

combatSkills = {
	ranged: associatedCharacterID.combatSkills.ranged,
	melee: associatedCharacterID.combatSkills.melee,
	edged: associatedCharacterID.combatSkills.edged,
	magic: associatedCharacterID.combatSkills.magic
}

inventory = associatedCharacterID.inventory;
activeEffects = associatedCharacterID.activeEffects;
resistances = associatedCharacterID.resistances;
immunities = associatedCharacterID.immunities;

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
		case "evasion":
			key = "bonusEvasion" break;
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
				case "bonusEvasion":
					sum += inventory[i].bonusEvasion; break;
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
		case "evasion":
			key = "bonusEvasion" break;
		default:
			show_error("No such stat '"+stat+"'", true)
			return 0;
	}
	var sum = 0;
	
	for(var i=0; i<array_length(activeEffects); i++;){
		if variable_struct_exists(activeEffects[i], key){
			switch(key){
				case "bonusArmor":
					if variable_struct_exists(activeEffects[i], "bonusArmor"){
						sum += activeEffects[i].bonusArmor;} 
						break;
				case "bonusSpeed":
					if variable_struct_exists(activeEffects[i], "bonusSpeed"){ 
						sum += activeEffects[i].bonusSpeed;}
						break;
				case "bonusHP":
					if variable_struct_exists(activeEffects[i], "bonusHP"){ 
						sum += activeEffects[i].bonusHP;}
						break;
				case "bonusMagicResist":
					if variable_struct_exists(activeEffects[i], "bonusMagicResist"){ 
						sum += activeEffects[i].bonusMagicResist;}
						break;
				case "bonusEvasion":
					if variable_struct_exists(activeEffects[i], "bonusEvasion"){ 
						sum += activeEffects[i].bonusEvasion;}
						break;
			}
		}
	}
	return sum;
}

itemBonuses = {
	hp: getItemBonus("hp"),
	spd: getItemBonus("speed"),
	armor: getItemBonus("armor"),
	magicResist: getItemBonus("magic resist"),
	evasion: getItemBonus("evasion"),
}

effectBonuses = {
	hp: getEffectBonus("hp"),
	spd: getEffectBonus("speed"),
	armor: getEffectBonus("armor"),
	magicResist: getEffectBonus("magic resist"),
	evasion: getEffectBonus("evasion"),
}

totalHP = baseStats.hp + itemBonuses.hp + effectBonuses.hp;
totalSpeed = baseStats.spd + itemBonuses.spd + effectBonuses.spd;
totalArmor = baseStats.armor + itemBonuses.armor + effectBonuses.armor;
totalMagicResist = baseStats.magicResist + itemBonuses.magicResist + effectBonuses.magicResist;
totalEvasion = baseStats.evasion + itemBonuses.evasion + effectBonuses.evasion;

maxHp = associatedCharacterID.maxHp
currentHp = associatedCharacterID.currentHp

attacks = [];
spells = []
specialActions = []; 
	//@TODO Add a for loop adding attacks. Attacks should be a struct detailing at minimum, 'Name', 'damage', and "hitChance'.
	for (var i=0; i<array_length(inventory);i++;){
		if variable_struct_exists(inventory[i], "attack"){
			array_push(attacks, inventory[i].attack);
		}
//@TESTING vvvvv idk if this is how we are doing it or naw. vvvvv
		if variable_struct_exists(inventory[i], "specialAction"){
			array_push(attacks, inventory[i].specialAction);
		}
	}
	try{
		spells = associatedCharacterID.spells	
	}catch(err){ spells = [] }
	

function listAttacks(){
	return attacks;	
}

function listSpecialActions(){
	return specialActions;	
}

function listItems(){
	var outputItems = [];
	for (var i=0; i<array_length(inventory);i++;){
		if variable_struct_exists(inventory[i], "combatMenu") && inventory[i].combatMenu == true{
			array_push(outputItems, inventory[i]);
		}
	}
	return outputItems;
}

function listSpells(){
	var outputSpells = [];
	for (var i=0; i<array_length(spells);i++;){
		if spells[i].combatMenu == true{
			array_push(outputSpells, spells[i]);
		}
	}
	return outputSpells;
}