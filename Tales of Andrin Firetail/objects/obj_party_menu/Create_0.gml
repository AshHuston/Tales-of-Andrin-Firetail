event_inherited()

function findCombatant(ovwID){
	var foundCombatant = 0
	var allCombatants = instance_find(obj_combat_manager, 0).combatants
	for (var i=0; i<array_length(allCombatants); i++){
		try{ if allCombatants[i].associatedCharacterID == ovwID{ foundCombatant = allCombatants[i] } }catch(err){}
	}
	return foundCombatant	
}

up_key = false
down_key = false
accept_key = false
right_key = false
left_key = false
back_key = false

party = [
global.OVERWORLD_ID_AARON,
global.OVERWORLD_ID_A,
global.OVERWORLD_ID_B,
global.OVERWORLD_ID_C,
]
selectionIndex = -1
hoveredCharacterId = 0
selectedCharacterId = 0
cam = view_get_camera(camera_get_active())
isCombat = false
if instance_exists(obj_combat_manager) { 
	cam  = view_get_camera(combatCam)
	isCombat = true
	}
closeWhenAccurate = false
closeOutFrameDelay = 5

displayVals = []
actualParty = []
for (var i=0; i<array_length(party); i++){
	if isCombat{
		var foundCombatant = findCombatant(party[i])
		if foundCombatant != 0 {
			party[i] = foundCombatant
			party[i].name = party[i].combatName
			}
	}
	if party[i] != 0{
		var data = 	{
		displayHp: party[i].currentHp,
		currentHp: party[i].currentHp,
		displayOtherBar: party[i].secondaryDisplayBarCurrent,
		currentOtherBar: party[i].secondaryDisplayBarCurrent
		}
		array_push(displayVals, data)
		array_push(actualParty, party[i])
	}
}
party = actualParty

shakeSelectorFrames = 0
function shakeSelector(){
	shakeSelectorFrames = 15
	playErrorSound()
}

setTopDepth(id)
depth -= 10
image_speed = image_speed*0.6

X = 0
Y = 0
prevCoords = [0,0]