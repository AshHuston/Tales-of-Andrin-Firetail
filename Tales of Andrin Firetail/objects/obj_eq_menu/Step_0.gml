function flipAlphas(){
	var buffSlotAlpha = listAlpha
	var buffListAlpha = slotsAlpha
	slotsAlpha = buffSlotAlpha
	listAlpha = buffListAlpha	
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
	hoveredCoords[X]++
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
//if hoveredSlot >= numOfSlots{hoveredSlot=0}
//if hoveredSlot < 0{hoveredSlot = numOfSlots-1}
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
		}else{
			heldCrystal = crystal_inventory[hoveredCrystal]	
		}
	}
}else{
	if isHoldingCrystal && accept_key && noLastPress {
		for (var i=0; i<array_length(crystal_inventory); i++){
			if crystal_inventory[i].name == heldCrystal.name{
				crystal_inventory[i].coords[0] = hoveredCoords[0]
				crystal_inventory[i].coords[1] = hoveredCoords[1]
			}
		}
		heldCrystal = noCrystal
	}
}
if heldCrystal == noCrystal{ isHoldingCrystal = false}