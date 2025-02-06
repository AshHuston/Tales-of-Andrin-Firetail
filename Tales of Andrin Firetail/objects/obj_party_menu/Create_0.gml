event_inherited()
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
selectionIndex = 0
hoveredCharacterId = 0
selectedCharacterId = 0
cam = view_get_camera(camera_get_active())
closeWhenAccurate = false
closeOutFrameDelay = 5

displayVals = []
actualParty = []
for (var i=0; i<array_length(party); i++){
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
}

setTopDepth(id)