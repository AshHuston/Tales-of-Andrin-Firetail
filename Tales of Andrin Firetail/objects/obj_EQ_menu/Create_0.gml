event_inherited()
up_key = false;
down_key = false;
left_key = false;
right_key = false;
accept_key = false;
back_key = false;

baseX = 20
baseY = 20

// Slot spacing refers to the X and Y spacing in pixels.
// Minimum of 24 due to the size of the sprite.
slot_spacing = 24
//[XgridPos, YgridPos]
slot_coordinates = [
	[2,1],
	[1,2],
	[3,2],
	[2,3],
	[1,4],
	[3,4],
	[2,5],
	[4,1],
	[4,3],
	[4,5],
	[5,2],
	[5,4]
]

numOfSlots = 12
range = 0.00
hoveredCoords = [2,1]
hoveredSlot = 0
noLastPress = true