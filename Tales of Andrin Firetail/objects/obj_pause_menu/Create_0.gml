event_inherited()
cam = view_get_camera(camera_get_active())
camX = camera_get_view_x(cam)
camY = camera_get_view_y(cam)
camWidth = camera_get_view_width(cam)
camHeight = camera_get_view_height(cam)
x = camX + (camWidth/20) //@TODO @DIAL Arbitrary for now. Will change when organizing the uis
y = camY + (camHeight/20)

setTopDepth(id)

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
 
badOptions = []
if !global.ALL_GAME_FLAGS.demo.eqExplained{array_push(badOptions, 3)} //EQ not unlocked.
array_push(badOptions, 4) //SaveLoad still in the works. @TODO Remove this

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
back_key = false

btn_pressed = false

objsThatWillPauseThis = [
	obj_settings_menu,
	obj_eq_menu,
	obj_party_menu,
	obj_inventory_menu,
	obj_saving_indicator,
	obj_splash_textbox
]

lastInput = ""