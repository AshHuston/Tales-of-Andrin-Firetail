event_inherited()
up_key = false;
down_key = false;
left_key = false;
right_key = false;
accept_key = false;
back_key = false;
right_key_tap = false;
up_key_tap = false;
down_key_tap = false;
//For readability
X = 0
Y = 1

#region Screen positioning
function setHudPosition(){
	cam = view_get_camera(camera_get_active())
	hudXOffset = camera_get_view_width(cam)/2.75
	hudYOffset = camera_get_view_height(cam)/3
	baseX = camera_get_view_x(cam) + hudXOffset
	baseY = camera_get_view_y(cam) + hudYOffset
	listX = baseX + 5//a buffer
	listY = baseY
}
setHudPosition()
#endregion

// Slot spacing refers to the X and Y spacing in pixels. Minimum of 24 due to the size of the sprite.
slot_spacing = 23	//??-->	 									     ^ ?????

//[XgridPos, YgridPos].
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

EMPTY = 0
FILLED = 1
slot_states = []
for (var slot=0; slot<array_length(slot_coordinates); slot++){slot_states[slot] = EMPTY}
crystal_list_coordinates = [6,0]
in_crystal_list = false
bufferCoords = false
bufferedCoords = []
numOfSlots = 7 ///////////////////////////////////////////
range = 0.00
hoveredCoords = [2,1]
hoveredSlot = 0
noLastPress = true
hoveredCrystal = 0
slotsAlpha = 1
listAlpha = 0.7
rightMostColumn = 0
crystal_inventory = global.CRYSTAL_INVENTORY
num_of_crystals = array_length(crystal_inventory)
longest_crystal_name_length = 0;
tallest_crystal_name_height = 0
for (var i=0; i<array_length(crystal_inventory); i++){
	var this_length = string_width(crystal_inventory[i].name)
	var this_height = string_height(crystal_inventory[i].name)
	if this_length > longest_crystal_name_length{
		longest_crystal_name_length = this_length
	}
	if this_height > tallest_crystal_name_height{
		tallest_crystal_name_height = this_height	
	}
}
op_borderX = 8
op_borderY = 6
op_space = tallest_crystal_name_height + 3;
noCrystal = {name : "none", sprite : spr_slot, coords: [6,0], other_filled_slots: []}
heldCrystal = noCrystal
isHoldingCrystal = false
shakeHeldCrystalFrames = 0