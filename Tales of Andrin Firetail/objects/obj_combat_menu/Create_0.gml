var cam = view_get_camera(combatManagerID.combatViewport)
camX = camera_get_view_x(cam)
camY = camera_get_view_y(cam)
camWidth = camera_get_view_width(cam)
camHeight = camera_get_view_height(cam)
xPadding = 5
xBase = camX + xPadding
x = xBase
yBase = camY + (camHeight/2)

setTopDepth(id)

op_border = 4
op_space = 16;

//Base Menu
option[0, 0] = {name: "Attacks"};
option[0, 1] = {name: "Spells"};
option[0, 2] = {name: "Special Actions"};
option[0, 3] = {name: "Inventory"};

//Settings Menu
option[1] = attacks;
option[2] = spells;
option[3] = specialActions;
option[4] = inventory;

for(var i=1; i<+array_length(option);i++){
	array_insert(option[i], 0, {name:"<--Back"});	
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

selectedAction = {name:"empty"}; 
chosenTargets = [];
continuingOperation = false
