event_inherited()
print("Inv menu " + string(random(50)))
cam = view_get_camera(camera_get_active())
if combatManagerID != 0  { cam = view_get_camera(combatCam) }
print( combatManagerID)
camX = camera_get_view_x(cam)
camY = camera_get_view_y(cam)
camWidth = camera_get_view_width(cam)
camHeight = camera_get_view_height(cam)
pauseMenuWidth = 73 // This obviously isnt pulling the data dynamically buit it should never change after we set it.
spaceFromPauseMenu = 3
x = camX + (camWidth/20) + pauseMenuWidth + spaceFromPauseMenu 
y = camY + (camHeight/20)

//Relocate the menu
var camXBuffer = 10
var camYBuffer = 10

if combatManagerID != 0  {
	camXBuffer = 15
	x =combatMenuID.x + camXBuffer
	camYBuffer = 10
	y = combatMenuID.y - camYBuffer
}


setTopDepth(id)
depth--
selectedAction = {}

op_border = 4
op_space = 16;

//Base Menu
option[0, 0] = {name: "Consumables"};
option[0, 1] = {name: "Equipment"};
option[0, 2] = {name: "Key Items"};
option[0, 3] = {name: "Other"};

//Set Menus
consumables = []
equipment = []
keyItems = []
otherItems = []
option[1] = consumables
option[2] = equipment
option[3] = keyItems
option[4] = otherItems

//sort items
function getItemsFromAaron(){
	var aaron =  global.OVERWORLD_ID_AARON
	var allItems = []
	array_copy(allItems, 0, aaron.inventory, 0, array_length(aaron.inventory))
	consumables = []
	equipment = []
	keyItems = []
	otherItems = []
	for (var i=0; i<array_length(allItems); i++){
		var menuPage = ""
		try{menuPage = allItems[i].menuPage}catch(err){menuPage = "Other"}
		switch(string_lower(menuPage)){
			case "consumables": 
				array_push(consumables, allItems[i])
				break;
			case "equipment": 
				array_push(equipment, allItems[i])
				break;
			case "key items": 
				array_push(keyItems, allItems[i])
				break;
			case "other": 
				array_push(otherItems, allItems[i])
				break;
		}
	}
	
	option[1] = consumables
	option[2] = equipment
	option[3] = keyItems
	option[4] = otherItems
}

getItemsFromAaron()


for(var i=1; i<+array_length(option);i++){
	//array_insert(option[i], 0, {name:"<--Back"}); //This would insert it at the TOP of the list. We would need to change the menu code to know what its selecting.
	array_push(option[i],{name:"<--Back"});	
}

op_length = 0;
menu_level = 0

width = 0
height = 0;

sel_btn_pressed_last = false;
btn_pressed = false;

pos = 0;

up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);
accept_key = keyboard_check(vk_return);
back_key = keyboard_check(vk_backspace)
up_down_stick = 0;
accept_btn = gamepad_button_value(0, gp_face1);

selectedPartyMember = ""
continuingOperation = false

textShakeFrames = 0