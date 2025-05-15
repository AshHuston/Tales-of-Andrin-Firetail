baseHp = round(random_range(11,15));
currentHp = baseHp;
statusEffect = [];
resistances = [];
immunities = [];
totalArmor = round(random_range(1,3));
totalMagicResist = 0;
totalSpeed = round(random_range(3, 4));
totalEvasion = 1;
monsterLevel = 1
event_inherited();
combatName = "Rat"
combatLogColor = c_red


swipe = {
	display_name: "Swipe",
	name: "Swipe",
	description: "Swpies at target with claws.",	//Only really needed for playable characters. Will show up on menu.
	targetID: "", 
	bonus_targetID: "", 
	dmg_type: "physical", 
	min_dmg: 2, 
	max_dmg: 4, 
	hit_chance: 95, 
	effect_chance: 0, 
	effect_type: "",
	frequency: round(random_range(8,12)),	//@TODO Figure out what kind of frequency numbers actually make sense.
	actionType:"attack",
	animation_index: spr_test_attack_claw,
	soundEffectId: snd_swipe,
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
	max_dmg: 2, 
	hit_chance: 80, 
	effect_chance: 15, 
	effect_type: "poison",
	frequency: 0,//round(random_range(2,4))+1200,//@TESTING
	actionType:"attack",
	animation_index: spr_bite,
	soundEffectId: snd_bite,
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

function getRandomTarget(){
	var partyIDs = getCombatPartyIDs(true);
	var targetIndex = round(random_range(0, array_length(partyIDs)-1));
	var target = partyIDs[targetIndex];	
	return target
}

function getAction(){	
	var actions = []
	for(var i = 0; i<array_length(attacks); i++){
		for(var n = 0; n<attacks[i].frequency; n++){
			array_push(actions, attacks[i])
		}
	}
	actions = array_shuffle(actions)
	var selectedAction = variable_clone(actions[0])
	
	if selectedAction.targetID == ""{
		
		selectedAction.targetID = getRandomTarget()
	}
	
	return selectedAction
}

damageAnimationSprite = sprite_index;
damageSoundEffect = snd_zombie_blah