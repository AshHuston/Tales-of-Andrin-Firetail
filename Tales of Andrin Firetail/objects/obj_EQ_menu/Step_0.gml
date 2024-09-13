up_key = input("up_cont");
down_key = input("down_cont");
left_key = input("left_cont");
right_key = input("right_cont");
accept_key = input("enter");
back_key = input("back");

var lastCoords = []
array_copy(lastCoords, 0, hoveredCoords, 0, 2)

if up_key && left_key{
	if noLastPress{
		hoveredCoords[0]--
		hoveredCoords[1]--
	}
	noLastPress = false
}
else if down_key && left_key{
	if noLastPress{
		hoveredCoords[0]--
		hoveredCoords[1]++
	}
	noLastPress = false
}
else if up_key && right_key{
	if noLastPress{
		hoveredCoords[0]++
		hoveredCoords[1]--
	}
	noLastPress = false
}
else if down_key && right_key{
	if noLastPress{
		hoveredCoords[0]++
		hoveredCoords[1]++
	}
	noLastPress = false
}
else {
	noLastPress = true	
}

var revertToLastCoords = true
for (var i = 0; i<numOfSlots; i++){ 
	if hoveredCoords[0] == slot_coordinates[i][0] && hoveredCoords[1] == slot_coordinates[i][1]{
		hoveredSlot = i
		revertToLastCoords = false
	}
}
if revertToLastCoords{hoveredCoords = lastCoords}

if hoveredSlot >= numOfSlots{hoveredSlot=0}
if hoveredSlot < 0{hoveredSlot = numOfSlots-1}