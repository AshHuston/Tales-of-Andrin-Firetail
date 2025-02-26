



//	THIS ENTIRE OBJECT IS A CLONE OF PAUSE_MENU RN AND NEEDS RTO BE ACTUALY CODED






op_border = 8
op_space = 16;

//Base Menu
option = [
	 "<-Back",
	 "Party",
	 "Inventory",
	 "Ephrin's Queen",
	 "Save Game",
	 "Settings",
	 "Main Menu"
 ]

op_length = array_length(option);

width = 175;
height = 0;

sel_btn_pressed_last = false;

pos = 0;

up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);
accept_key = keyboard_check(vk_return);
up_down_stick = 0;
accept_btn = gamepad_button_value(0, gp_face1);

btn_pressed = false

objsThatWillPauseThis = [
	obj_settings_menu,
	obj_eq_menu,
	obj_party_menu,
	obj_inventory_menu,
	obj_saving_indicator
]