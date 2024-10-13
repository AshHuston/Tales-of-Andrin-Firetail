setHudPosition()

if input("start"){instance_destroy(self)}

function flipAlphas(){
	var buffSlotAlpha = listAlpha
	var buffListAlpha = slotsAlpha
	slotsAlpha = buffSlotAlpha
	listAlpha = buffListAlpha	
}

function getSlotByCoords(input_coords){
	for (var i = 0; i<numOfSlots; i++){ 
		if string(slot_coordinates[i]) == string(input_coords){
			return i	
		}
	}
	return -1
}

function getCrystalByCoords(input_coords){
	for (var i=0; i<array_length(crystal_inventory); i++){
		if string(crystal_inventory[i].coords) == string(input_coords){
			return i
		}
		for (var slot=0; slot<array_length(crystal_inventory[i].other_filled_slots); slot++){ 
			if string(crystal_inventory[i].other_filled_slots[slot]) == string(input_coords){
				return i
			}
		}
	}
	return -1
}

up_key = input("up_cont");
down_key = input("down_cont");
left_key = input("left_cont");
right_key = input("right_cont");
accept_key = input("enter");
back_key = input("back");
right_key_tap = input("right");
up_key_tap = input("up");
down_key_tap = input("down");
isHoldingCrystal = false
if heldCrystal != noCrystal{ isHoldingCrystal = true}
switch(numOfSlots){
	case 4:
		rightMostColumn = 3; break;
	case 7:
		rightMostColumn = 3; break;
	case 12:
		rightMostColumn = 5; break;
}
var lastCoords = []
array_copy(lastCoords, 0, hoveredCoords, 0, 2)
if up_key && left_key{
	if noLastPress{
		hoveredCoords[X]--
		hoveredCoords[Y]--
	}
	noLastPress = false
}
else if down_key && left_key{
	if noLastPress{
		hoveredCoords[X]--
		hoveredCoords[Y]++
	}
	noLastPress = false
}
else if up_key && right_key{
	if noLastPress{
		hoveredCoords[X]++
		hoveredCoords[Y]--
	}
	noLastPress = false
}
else if down_key && right_key{
	if noLastPress{
		hoveredCoords[X]++
		hoveredCoords[Y]++
	}
	noLastPress = false
}
else {
	noLastPress = true	
}

// Allows for a rightmost hovered cell to move to the crystalList via pressing Right, no diagonal needed.
if noLastPress && hoveredCoords[X] == rightMostColumn && right_key_tap{
	hoveredCoords[X] = crystal_list_coordinates[X]
	noLastPress = false
}
var revertToLastCoords = true
for (var i = 0; i<numOfSlots; i++){ 	
	if hoveredCoords[X] == slot_coordinates[i][X] && hoveredCoords[Y] == slot_coordinates[i][Y]{
		hoveredSlot = i
		revertToLastCoords = false
	}
}
if in_crystal_list = false{ bufferCoords = true}
if hoveredCoords[X] == crystal_list_coordinates[X]{
	in_crystal_list = true
}
if in_crystal_list && bufferCoords{
	bufferCoords = false
	bufferedCoords = lastCoords
	flipAlphas()
}
if in_crystal_list{
	revertToLastCoords = false
	hoveredSlot = -1
	}
if revertToLastCoords{hoveredCoords = lastCoords}
if in_crystal_list{
	if left_key{
		hoveredCoords = bufferedCoords
		flipAlphas()
		in_crystal_list = false
	}
}


// Ensure slots are marked as filled or not and equips appropriate crystals. Its so nested its awful.
global.EQUIPPED_CRYSTALS = []
slot_states = [EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY]
for (var slot=0; slot<array_length(slot_coordinates); slot++){
	var coords = slot_coordinates[slot]
	if slot_states[slot] == EMPTY{
		for (var i=0; i<array_length(crystal_inventory); i++){
			// Mark slots as FILLED
			if string(crystal_inventory[i].coords) == string(coords){
				// Add crystal to equipped crystals
				if !array_contains(global.EQUIPPED_CRYSTALS, crystal_inventory[i]){
					array_push(global.EQUIPPED_CRYSTALS, crystal_inventory[i])
				}
				// Fill master slot
				slot_states[slot] = FILLED
				//Fill slave_slots
				crystal_inventory[i].other_filled_slots = []
				for (var n=0; n<array_length(crystal_inventory[i].slave_cells); n++){
					var slaveCoords = []
					array_copy(slaveCoords, 0, crystal_inventory[i].slave_cells[n], 0, array_length(crystal_inventory[i].slave_cells[n]))
					slaveCoords[0] += coords[0]
					slaveCoords[1] += coords[1]
					slot_states[getSlotByCoords(slaveCoords)] = FILLED
					array_push(crystal_inventory[i].other_filled_slots, slaveCoords)
				}
			}
		}
	}
}


// Pick up and place crystals
if in_crystal_list{
	if up_key_tap && noLastPress{
		hoveredCrystal--	
	}
	if down_key_tap && noLastPress{
		hoveredCrystal++	
	}
	if hoveredCrystal >= num_of_crystals {hoveredCrystal=0}
	if hoveredCrystal < 0 {hoveredCrystal = num_of_crystals-1}
	if accept_key{
		if isHoldingCrystal{
			heldCrystal = noCrystal
		}else if string(crystal_inventory[hoveredCrystal].coords) == string(noCrystal.coords){
			heldCrystal = crystal_inventory[hoveredCrystal]	
		}
	}
}else{
	if isHoldingCrystal && accept_key && noLastPress {
		// Check that there are no filled slots in our way
		var canPlaceCrystal = true
		if isHoldingCrystal{
			if slot_states[getSlotByCoords(hoveredCoords)] == FILLED {canPlaceCrystal = false}
			var slaveCells = heldCrystal.slave_cells
			for (var i=0; i<array_length(slaveCells); i++){
				var slaveCoords = []
				array_copy(slaveCoords, 0, slaveCells[i], 0, array_length(slaveCells[i]))
				slaveCoords[0] += hoveredCoords[0]
				slaveCoords[1] += hoveredCoords[1]
				try{
					if slot_states[getSlotByCoords(slaveCoords)] == FILLED {canPlaceCrystal = false}
				}catch(_exception){
					canPlaceCrystal = false
				}
			}
		}
		if canPlaceCrystal{
			for (var i=0; i<array_length(crystal_inventory); i++){
				//Set held crystal coords to the hovered slot.
				if crystal_inventory[i].name == heldCrystal.name{
					crystal_inventory[i].coords[0] = hoveredCoords[0]
					crystal_inventory[i].coords[1] = hoveredCoords[1]
				}
			}
			heldCrystal = noCrystal
		}else{
		shakeHeldCrystalFrames = 15	
		}
	}
	if !isHoldingCrystal && accept_key && noLastPress{
		// Pick up the crystal currently at hoveredCoords
		var crystalNum = getCrystalByCoords(hoveredCoords)
		if crystalNum != -1{
			heldCrystal = crystal_inventory[crystalNum]
			hoveredCoords = heldCrystal.coords//moves hover to master cell of the crystal so it doesnt move
			heldCrystal.coords = [6,0] //moves the crystal off the board
		}
	}
}
if heldCrystal == noCrystal {isHoldingCrystal = false}

