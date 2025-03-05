function updateSavedStats(){
	var overworldIDs = [
		global.OVERWORLD_ID_AARON,
		global.OVERWORLD_ID_A,
		global.OVERWORLD_ID_B,
		global.OVERWORLD_ID_C,
		]
	var partyMembers = ["", "", "", ""]
	for (var i=0; i<array_length(overworldIDs); i++){
		//print(overworldIDs[i])
		//print(object_get_name(overworldIDs[i].object_index))
		if overworldIDs[i] != 0 {partyMembers[i] = string_lower(overworldIDs[i].name)}
	}
	var charNames = struct_get_names(global.CHARACTER_STATS)
	for (var i=0; i<array_length(charNames); i++){
		var characterData = {}
		if array_contains(partyMembers, charNames[i]){
			var charID = NaN
			for (var n=0; n<array_length(overworldIDs); n++){
				if overworldIDs[n] != 0 {
					if string_lower(overworldIDs[n].name) == charNames[i] {charID = overworldIDs[n]}
				}
			}
			characterData = {
				maxHp:						charID.maxHp,
				level:						charID.level,
				armor:						charID.armor,
				evasion:					charID.evasion,
				totalExp:					charID.totalExp,
				currentHp:					charID.currentHp,
				immunities:					charID.immunities,
				magicResist:				charID.magicResist,
				combatSpeed:				charID.combatSpeed,
				resistances:				charID.resistances,
				combatSkills:				charID.combatSkills,
				activeEffects:				charID.activeEffects,
				secondaryDisplayBar:		charID.secondaryDisplayBar,
				secondaryDisplayBarMax:		charID.secondaryDisplayBarMax,
				secondaryDisplayBarCurrent: charID.secondaryDisplayBarCurrent
			}
			global.CHARACTER_STATS[$ charNames[i]] = characterData
		}
	}
	//print("Charcaters updated")
}

// THESE STATS ARE ARBITRARY AND NEED TO BE WORKED OUT

// These stats represent the BASE stats. Not accounting for items, spells, or other gear.
global.CHARACTER_STATS = {
	aaron : {
		maxHp:						40,
		level:						1,
		armor:						3,
		evasion:					5,
		totalExp:					0,
		currentHp:					40,
		immunities:					[],
		magicResist:				0,
		combatSpeed:				5,
		resistances:				[],
		activeEffects:				[],
		secondaryDisplayBar:		"MP",
		secondaryDisplayBarMax:		45,
		secondaryDisplayBarCurrent: 45,
		combatSkills:				{
										edged: 25,
										ranged:15,
										melee: 20,
										magic: 15
									},
	},
	
	kylah : {
		maxHp:						35,
		level:						1,
		armor:						3,
		evasion:					5,
		totalExp:					0,
		currentHp:					35,
		immunities:					[],
		magicResist:				1,
		combatSpeed:				4,
		resistances:				["fire"],
		activeEffects:				[],
		secondaryDisplayBar:		"MP",
		secondaryDisplayBarMax:		45,
		secondaryDisplayBarCurrent: 45,
		combatSkills:				{
										edged:  5,
										ranged: 5,
										melee: 10,
										magic: 35
									},
		},
	
	roy : {
		maxHp:						65,
		level:						1,
		armor:						3,
		evasion:					5,
		totalExp:					0,
		currentHp:					65,
		immunities:					[],
		magicResist:				0,
		combatSpeed:				5,
		resistances:				[],
		activeEffects:				[],
		secondaryDisplayBar:		"Energy",
		secondaryDisplayBarMax:		45,
		secondaryDisplayBarCurrent: 45,
		combatSkills:				{
										edged: 25,
										ranged: 3,
										melee: 20,
										magic: 15
									},
	},
	
	titus : {
		maxHp:						65,
		level:						1,
		armor:						3,
		evasion:					5,
		totalExp:					0,
		currentHp:					65,
		immunities:					[],
		magicResist:				0,
		combatSpeed:				5,
		resistances:				[],
		activeEffects:				[],
		secondaryDisplayBar:		"Energy",
		secondaryDisplayBarMax:		45,
		secondaryDisplayBarCurrent: 45,
		combatSkills:				{
										edged: 25,
										ranged: 3,
										melee: 20,
										magic: 15
									},
	},
}
