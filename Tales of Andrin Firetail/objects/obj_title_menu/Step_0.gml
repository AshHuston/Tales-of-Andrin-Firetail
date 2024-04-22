up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);
accept_key = keyboard_check_pressed(vk_return);
//if 0.25 > gamepad_axis_value(0, gp_axislv) > -0.25 {up_down_stick = gamepad_axis_value(0, gp_axislv);}
accept_btn = gamepad_button_value(0, gp_face1);

//Store num of options in current menu
op_length = array_length(option[menu_level]);

//adjust window
 height = 12 +(op_length*(20 + op_space + op_border));
 
 
if btn_pressed == false
	{
	if down_key{pos++;}
	if up_key{pos--;}
		if pos>=op_length{pos=0};
		if pos<0 {pos=op_length-1};
		btn_pressed = true;
	}
if !down_key && !up_key {btn_pressed = false}
//if  (input("down_cont") - input("up_cont")) == 0 {btn_pressed = false}


//Clicky da button
if (accept_key) 
//&& !sel_btn_pressed_last
{
	var _sml = menu_level;
	
	
	switch(menu_level)
	{
		//pause menu
		case 0:
		switch(pos)
		{
		//ATTACKS
			case 0:
			menu_level = 1;
			break;
	
		//SPELLS
			case 1:
			menu_level = 2;
			break;
		
		//SPECIAL ACTIONS		
			case 2:
			menu_level = 3;
			break;
		
		//INVENTORY
			case 3:
			menu_level = 4;
			break;
		
		//NOTHING		
			case 4:
		
			break;
		}
		break;
		
		//settings menu
		case 1:
			switch (pos){
				case 0:
					menu_level = 0;
					break;
					
				default:
				show_debug_message(attacks[pos].name);
			}
			 
		break;
		
		case 2:
			switch (pos){
				case 0:
					menu_level = 0;
					break;
					
				default:
				show_debug_message(spells[pos].name); 
			}
		break;
		
		case 3:
		switch (pos){
				case 0:
					menu_level = 0;
					break;
					
				default:
				show_debug_message(specialActions[pos].name); 
		}
		break;
		
		case 4:
		switch (pos){
				case 0:
					menu_level = 0;
					break;
					
				default:
				show_debug_message(inventory[pos]);
		}
		break;
		
	}	
	//prep for next menu
	sel_btn_pressed_last = true;
	if _sml != menu_level{pos=0;}
	op_length = array_length(option[menu_level]);
} else {sel_btn_pressed_last = false;}

//if input("enter") {sel_btn_pressed_last = true;}