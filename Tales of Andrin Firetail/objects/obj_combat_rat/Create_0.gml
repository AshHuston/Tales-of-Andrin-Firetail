baseHp = round(random_range(7,11));
currentHp = baseHp;
statusEffect = [];
resistances = [];
immunities = [];
totalArmor = round(random_range(1,3));
totalMagicResist = 0;
totalSpeed = round(random_range(3, 5));
totalEvasion = 1;
monsterLevel = 1
event_inherited();
combatName = "Rat"
combatLogColor = c_red


swipe = {
	display_name: "Swipe",
	description: "Swpies at target with claws.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 1, 
	max_dmg: 30, 
	hit_chance: 90, 
	effect_chance: 0, 
	effect_type: "",
	frequency: round(random_range(8,12)),	//@TODO Figure out what kind of frequency numbers actually make sense.
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

bite = {
	display_name: "bite",
	name: "bite",
	description: "bites at target. Low chance to poison.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 1, 
	max_dmg: 20, 
	hit_chance: 80, 
	effect_chance: 30, 
	effect_type: "poison",
	frequency: round(random_range(4,8)),
	actionType:"attack",
	animation_index: spr_test_attack_claw,
	logMessage: [
		{text: "*ACTIVE", color: c_aqua},
		{text: "bites", color: c_white},
		{text: "*TARGET", color: c_olive},
		{text: "dealing", color: c_white},
		{text: "*DAMAGE", color: c_white},
		{text: "damage.", color: c_white},
		]
}

attacks = [swipe, bite]

function getAction(){
	//Pick target
	var partyIDs = []
		partyIDs = getCombatPartyIDs();
	//var targetIndex = round(random_range(0,array_length(partyIDs)));
	var targetIndex = 0;
	var target = partyIDs[targetIndex];
	
	// Pick attack
	bite.targetID = target; //cuurently only returns bite lol.
	return bite;
}

damageAnimationSprite = sprite_index;
damageSoundEffect = snd_zombie_blah