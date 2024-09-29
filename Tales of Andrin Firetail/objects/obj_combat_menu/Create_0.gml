//width = 175;
//height = 100;

var cam = view_get_camera(combatManagerID.combatViewport)
x = camera_get_view_x(cam) + (camera_get_view_width(cam)/2) //@TODO Arbitrary for now. Will change when organizing the combat uis
y = camera_get_view_y(cam) + (camera_get_view_height(cam)/2)

for (var i = 0; i<instance_count; i++){
	var checkDepth = instance_id_get(i).depth
	if checkDepth < depth{ 
		depth = checkDepth-1
		}	
}

op_border = 8
op_space = 16;

//Base Menu
option[0, 0] = "Attacks";
option[0, 1] = "Spells";
option[0, 2] = "Special Actions";
option[0, 3] = "Inventory";

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