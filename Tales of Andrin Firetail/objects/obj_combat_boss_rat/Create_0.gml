baseHp = 80
currentHp = baseHp;
statusEffect = [];
resistances = [];
immunities = [];
totalArmor = round(random_range(3,5));
totalMagicResist = round(random_range(5,9));
totalSpeed = round(random_range(3, 5));
totalEvasion = 1;
monsterLevel = 5
event_inherited();
combatName = "Sergio"
combatLogColor = c_orange

swipe = {
	name: "Swipe",
	description: "Swpies at target with claws.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 1, 
	max_dmg: 3, 
	hit_chance: 90, 
	effect_chance: 0, 
	effect_type: "",
	frequency: round(random_range(4,9)),	//@TODO Figure out what kind of frequency numbers actually make sense.
	actionType:"attack",
	animation_index: spr_test_attack_claw,
	logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "slashes", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "with it's claws, dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
}

flames = {
	name: "Incinerate",	//Only really needed for playable characters. Will show up on menu.
	description: "Burns all enemies",	//Only really needed for playable characters. Will show up on menu.
	targetID: "all players", //Should be "all", "all enemies", or whatever the combat system's equivilent is.
	bonus_targetID: "", 
	dmg_type: "fire", 
	min_dmg: 5, 
	max_dmg: 15, 
	hit_chance: 85, 
	effect_chance: 0, 
	effect_type: "",
	frequency: 5,
	combatMenu: true,
	actionType: "spell",
	spellType: "attack",
	animation_index: spr_test_attack_flame,
	cost_type: "MP",
	cost_value: 10,
	logMessage: [
	{text: "*ACTIVE", color: c_aqua},
	{text: "burns", color: c_white},
	{text: "*TARGET", color: c_olive},
	{text: "dealing", color: c_white},
	{text: "*DAMAGE", color: c_white},
	{text: "damage.", color: c_white},
	]
}

attacks = [swipe, flames]

function getAction(){	
	var actions = []
	for(var i = 0; i<array_length(attacks); i++){
		for(var n = 0; n<attacks[i].frequency; n++){
			array_push(actions, attacks[i])
		}
	}
	actions = array_shuffle(actions)
	print(actions)
	var selectedAction = actions[0]
	
	if selectedAction.targetID == ""{
	var partyIDs = getCombatPartyIDs();
	var targetIndex = round(random_range(0, array_length(partyIDs)-1));
	var target = partyIDs[targetIndex];
	selectedAction.targetID = target
	}
	
	return selectedAction
}

damageAnimationSprite = sprite_index;
damageSoundEffect = snd_zombie_blah