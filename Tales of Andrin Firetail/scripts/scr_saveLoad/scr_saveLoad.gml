var rawKey = "AaronLosesHisArm"
global.ENCRYPTION_KEY = array_to_ascii_vals(to_char_array(rawKey))

function encrypt(rawText){
	//Get chars
	var characters = to_char_array(rawText)
	
	//Convert to ASCII values
	var asciiVals = array_to_ascii_vals(characters)
	
	// loop key to be long enough
	var dataLen = array_length(asciiVals)
	var thisKey = array_create(array_length(global.ENCRYPTION_KEY))
	array_copy(thisKey, 0, global.ENCRYPTION_KEY, 0, array_length(global.ENCRYPTION_KEY))
	while true{
		if dataLen > array_length(global.ENCRYPTION_KEY){
			thisKey = array_concat(thisKey, global.ENCRYPTION_KEY)
		}
		else{
			break	
		}
	}
	
	//Do the bitwise crap with the ^ 
	//@TODO Fix the "printable range" issue
		
	var cipherText = ""
	for (var i=0; i<array_length(asciiVals); i++){
		var char = asciiVals[i] ^ thisKey[i]
		cipherText += chr(char)
		//show_debug_message(asciiVals[i])
		//show_debug_message(thisKey[i])
		show_debug_message(char)
		show_debug_message(chr(char))
		//show_debug_message("-----------------------")
	}
	
	return cipherText
}

function decrypt(cipherText){
	
	return rawText
}

function saveGame(){
	updateSavedStats()
	var indicator = instance_create_depth(0,0,0, obj_saving_indicator)
	var saveData = {}
	var overworldIDs = [
	global.OVERWORLD_ID_AARON,
	global.OVERWORLD_ID_A,
	global.OVERWORLD_ID_B,
	global.OVERWORLD_ID_C,
	]
	
	#region partyMembers 
	var partyMembers = ["", "", "", ""]
	for (var i=0; i<array_length(overworldIDs); i++){
		if overworldIDs[i] != 0 {partyMembers[i] = string_lower(overworldIDs[i].name)}
	}
	saveData.partyMembers = partyMembers
	#endregion
	#region characterBaseStats	
	/*Currently only for Active party members
	var charNames = struct_get_names(global.CHARACTER_STATS)
	var stats = global.CHARACTER_STATS
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
				name:						charID.name,
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
		}else{ characterData.name = charNames[i] }
		//global.CHARACTER_STATS[$ charNames[i]] = characterData
	}
	*/
	saveData.characterBaseStats = global.CHARACTER_STATS
	#endregion
	#region inventory
	saveData.inventory = global.PLAYER_INVENTORY
	#endregion
	#region Gold
	saveData.gold = global.PLAYER_GOLD
	#endregion
	#region Equipped items			X
	#endregion
	#region EQinventory
	saveData.EQinventory = global.CRYSTAL_INVENTORY
	#endregion
	#region EQ Equipped				
	saveData.EQEquipped = global.EQUIPPED_CRYSTALS
	#endregion
	#region Game flags				
	saveData.gameFlags = global.ALL_GAME_FLAGS
	#endregion
	#region settings				X
	#endregion
	#region Save location			
	saveData.roomId = room_get_name(room)
	saveData.aaronCoords = [global.OVERWORLD_ID_AARON.x, global.OVERWORLD_ID_AARON.y]
	#endregion
	#region State of loaded area	X
	#endregion

	#region Determine file
	var filename = "TEST_FILE.txt"
	var file = file_text_open_write(filename)
	#endregion

	#region Form the JSON and write it to file.
	if file != -1{ // -1 would be an error opening the file.
		var jsonString = json_stringify(saveData, true)
		file_text_write_string(file, jsonString)
		file_text_close(file)
		print("Game saved!!!")
		indicator.selfDestruct(20)
	}else{
		// Handle said error.
	}
	#endregion
}

function loadGame(){
	function spawn_ovw_party_member(name){
		var allStats = global.CHARACTER_STATS
		var objId = noone
		var stats = {}
		switch(string_lower(name)){
			case "kylah":	objId = obj_overworld_kylah; stats = allStats.kylah break;
			case "roy":	objId = obj_overworld_roy; stats = allStats.roy break;
			default:
		}
		if objId != noone{ instance_create_depth(0,0,0, objId, stats) }
	}
	
	#region Determine file
	var filename = "TEST_FILE.txt"
	var file = file_text_open_read(filename)
	#endregion

	#region Read the JSON from the file.
	if file != -1{ // -1 would be an error opening the file.
		var jsonstring = ""
		while true{
			jsonstring = string_concat(jsonstring, file_text_read_string(file))
			file_text_readln(file);
			if file_text_eof(file){
				break;
			}
		}
	}else{
		// Handle said error.
	}
	var saveData = json_parse(jsonstring)
	#endregion
	
	var overworldIDs = [
	global.OVERWORLD_ID_AARON,
	global.OVERWORLD_ID_A,
	global.OVERWORLD_ID_B,
	global.OVERWORLD_ID_C,
	]
	
	#region partyMembers			
	var partyMembers = saveData.partyMembers
	#endregion
	#region characterBaseStats		
	global.CHARACTER_STATS = saveData.characterBaseStats
	for (var i=0; i<array_length(partyMembers); i++){ spawn_ovw_party_member(partyMembers[i]) }
	#endregion
	#region inventory				
	global.PLAYER_INVENTORY = saveData.inventory
	#endregion
	#region Gold
	global.PLAYER_GOLD = saveData.gold
	#endregion
	#region Equipped items			X
	#endregion
	#region EQinventory				
	global.CRYSTAL_INVENTORY = saveData.EQinventory
	#endregion
	#region EQ Equipped				
	global.EQUIPPED_CRYSTALS = saveData.EQEquipped
	#endregion
	#region Game flags				
	global.ALL_GAME_FLAGS = saveData.gameFlags
	#endregion
	#region settings				X
	#endregion
	#region Save location			
	room_goto(asset_get_index(saveData.roomId))
	global.OVERWORLD_ID_AARON.x = saveData.aaronCoords[0]
	global.OVERWORLD_ID_AARON.y = saveData.aaronCoords[1]
	#endregion
	#region State of loaded area	X
	#endregion

	print("Game loaded!")
}