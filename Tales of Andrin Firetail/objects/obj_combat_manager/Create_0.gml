event_inherited()

hideCombatLog = true
combatLogExtraLines = 0
addExtraLine = false
currentX = 0
setCurrentToOffScreen = true
combatLogEntries = []			// Each entry should have {text:"Words", color:c_white}
combatLogEntriesOnDisplay = []	// Should have {text:"Words", color:c_white, frames:default_frames, alpha:for_fade_out}
waitFrames = 3

drawSelector = true
preDesignatedTargets = ["all enemies", "all"] // Targets that will not require selection.
var up_key 
var down_key 
var accept_key 
var back_key 
overworldViewport = 0
overworldCameraX = 0
overworldCameraY = 0
combatViewport = 7
for (var i=0; i<7; i++;){
	if view_get_visible(i){
		overworldViewport = i
		overworldCameraX = view_get_xport(i)
		overworldCameraY = view_get_yport(i)
	}
	view_set_visible(i, false)
}
view_set_visible(combatViewport, true)
combatCameraX = camera_get_view_x(view_get_camera(combatViewport)) 
combatCameraY = camera_get_view_y(view_get_camera(combatViewport))







// ---------------------------------------- MONSTER RELOCATION --------------------------------------------------
monsters = [
	mob1,
	mob2,
	mob3,
	mob4,
	mob5
]
X = 0
Y = 1
monsterCoords = [[],[],[],[],[]]

for(var i=0; i<array_length(monsters); i++;){
	if monsters[i] == ""{array_delete(monsters, i, 1)}
}

switch(array_length(monsters)){
		case 1:
			monsterCoords = global.COMBAT_POSITIONING.oneMonster	break;
		case 2:
			monsterCoords = global.COMBAT_POSITIONING.twoMonsters	break;
		case 3:
			monsterCoords = global.COMBAT_POSITIONING.threeMonsters	break;
		case 4:
			monsterCoords = global.COMBAT_POSITIONING.fourMonsters	break;
		case 5:
			monsterCoords = global.COMBAT_POSITIONING.fiveMonsters	break;	
	}		
for(var i=0; i<array_length(monsterCoords); i++;){
	monsterCoords[i][X] += combatCameraX
	monsterCoords[i][Y] += combatCameraY
	monsters[i].x = monsterCoords[i][X]
	monsters[i].y = monsterCoords[i][Y]
}
// -----------------------------------------------------------------------------------------------------------



/**
 * Creates the combat characters for party members.
 * @param {any*} partyIDs overworld object IDs for party members.
 * @returns {Array<Id.Instance<obj_combat_aaron>>} obj_combat_party_member object IDs, in the order the overworld ids were provided.
 */
function createPartyCombatObjects(partyIDs){
	var combatObjectIDs = [];
	var combatCharID
	
	for (var i=0; i<array_length(partyIDs); i++;){
		//show_debug_message(partyIDs[i]);
		if i==0 {combatCharID = instance_create_depth(x,y, 0, obj_combat_aaron, {associatedCharacterID:partyIDs[i]});}
		else{combatCharID = instance_create_depth(x, y-100, 0, obj_combat_party_member, {associatedCharacterID:partyIDs[i]});}
		array_push(combatObjectIDs, combatCharID);
	}
	return combatObjectIDs;
}



//-------------------COMBAT START----------------------

	//Begin transition animation

	//move to combat room

	//Create list of combat object IDs.
		combatants = []
		// Aaron + 0-3 party members.
		var charAaron = global.OVERWORLD_ID_AARON;
		var charA = global.OVERWORLD_ID_A;			// Currently these all are the overworld IDs,
		var charB = global.OVERWORLD_ID_B;			// they will need to be the actual combat objects.
		var charC = global.OVERWORLD_ID_C;			// Right?
		
		
		//Make sure group size is accurate.
		var partyIDs = [charAaron, charA, charB, charC];
			
		for (var i=0;i<array_length(partyIDs);i++;){
			//show_debug_message(partyIDs[i])
			if 	partyIDs[i] == 0{
				array_delete(partyIDs, i, 1);
				i = 0;
			}
		}
		
		partyIDs = createPartyCombatObjects(partyIDs);
		// Enemies are either premade or created by their own function. Overworld enemy will generate it.
		// Either way, their ids will get passed in via the struct.


	//Determine positioning
		//Look at globalvar for party
		IDorder = [];
				
		//Fill out IDorder[]
		for(var i=0;i<array_length(global.COMBAT_ORDERING);i++;){
			switch(string_upper(global.COMBAT_ORDERING[i])){
				case "AARON": IDorder[i] = charAaron; break;
				case "A": IDorder[i] = charA; break;
				case "B": IDorder[i] = charB; break;
				case "C": IDorder[i] = charC; break;
			}
		}
	
		for (var i=0;i<array_length(IDorder);i++;){
			show_debug_message(IDorder[i])
			if IDorder[i] == 0{ continue }
			switch(i){
				case 0:
					partyIDs[i].x = global.COMBAT_POSITIONING.fourCharacters[0][0] + combatCameraX;
					partyIDs[i].y = global.COMBAT_POSITIONING.fourCharacters[0][1] + combatCameraY;
					break;
					
				case 1: 
					partyIDs[i].x = global.COMBAT_POSITIONING.fourCharacters[1][0] + combatCameraX;
					partyIDs[i].y = global.COMBAT_POSITIONING.fourCharacters[1][1] + combatCameraY;
					break;				
			
				case 2: 
					partyIDs[i].x = global.COMBAT_POSITIONING.fourCharacters[2][0] + combatCameraX;
					partyIDs[i].y = global.COMBAT_POSITIONING.fourCharacters[2][1] + combatCameraY;
					break;
					
				case 3: 
					partyIDs[i].x = global.COMBAT_POSITIONING.fourCharacters[3][0] + combatCameraX;
					partyIDs[i].y = global.COMBAT_POSITIONING.fourCharacters[3][1] + combatCameraY;
					break;
			}
		}
		
		//Receive ids/positions from monster struct
		var mobs = [mob1, mob2, mob3, mob4, mob5]; //This has us maxing out theorerically at 5 enemies, but depending on what our highest number is we can just add more, it will ignore empty ones.
		
		//Combine combatants
		for (var i=0;i<array_length(mobs);i++;){
			if mobs[i] != ""{
				array_push(combatants, mobs[i]);
			}
		}
		
		for (var i=0;i<array_length(partyIDs);i++;){
			array_push(combatants, partyIDs[i]);
		}
		
		
		
	//Start combat clock
	step = "Determine active combatant";
	activeCombatant = combatants[0];
	action = {name:"empty"};
	targets = [];
	menu = "";
	hovering = -1;
	canStillGo = []
	originalScaleX = 0;
	originalScaleY = 0;
	activeCombatantScale = 1.2;
	
	//global.COMBATANTS = combatants;
	array_copy(global.COMBATANTS, -1, combatants, 0, array_length(combatants))