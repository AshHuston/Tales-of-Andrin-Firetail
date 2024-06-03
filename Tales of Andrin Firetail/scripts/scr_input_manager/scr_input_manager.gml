var lstick_digital_vals = [-1,-1,-1,-1];
var rstick_digital_vals = [-1,-1,-1,-1];
#macro RIGHT 0
#macro UP 1
#macro LEFT 2
#macro DOWN 3

function input(button)
{
	if gamepad_is_connected(0) == false
	{
		switch (button)
		{
			case "right_cont": return keyboard_check(vk_right); break;
			case "left_cont": return keyboard_check(vk_left); break;
			case "up_cont": return keyboard_check(vk_up); break;
			case "down_cont": return keyboard_check(vk_down); break;
			
			case "W_cont": return keyboard_check(ord("W")); break;
			case "A_cont": return keyboard_check(ord("A")); break;
			case "S_cont": return keyboard_check(ord("S")); break;
			case "D_cont": return keyboard_check(ord("D")); break;
			
			case "right": if keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) {return 1;} else {return 0;}; break;
			case "left": if keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) {return 1;} else {return 0;}; break;
			case "up": if keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) {return 1;} else {return 0;}; break;
			case "down": if keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) {return 1;} else {return 0;}; break;
			
			case "enter": return keyboard_check_pressed(vk_enter); break;
			case "trigger_click_pressed": return mouse_check_button_pressed(mb_left); break;
			case "trigger_click": return mouse_check_button(mb_left); break;
			case "start": return keyboard_check_pressed(vk_escape); break;
			case "I": return keyboard_check_pressed(ord("I")); break;
			case "U": return keyboard_check_pressed(ord("U")); break;
			case "W": return keyboard_check_pressed(ord("W")); break;
			case "A": return keyboard_check_pressed(ord("A")); break;
			case "S": return keyboard_check_pressed(ord("S")); break;
			case "D": return keyboard_check_pressed(ord("D")); break;
			default: return 0;
		}
	}
	if gamepad_is_connected(0) == true
	{
		gamepad_set_axis_deadzone(0, 0.2);
		switch (button)
		{ 
			case "rstick_x_val": return gamepad_axis_value(0, gp_axisrh); break;
			case "rstick_y_val": return gamepad_axis_value(0, gp_axisrv); break;
			case "lstick_x_val": return gamepad_axis_value(0, gp_axislh); break;
			case "lstick_y_val": return gamepad_axis_value(0, gp_axislv); break;
			
			case "left_cont": return -clamp(gamepad_axis_value(0, gp_axislh), -1,0); break;
			case "right_cont": return clamp(gamepad_axis_value(0, gp_axislh), 0, 1); break;
			case "up_cont": return -clamp(gamepad_axis_value(0, gp_axislv), -1,0); break;
			case "down_cont": return clamp(gamepad_axis_value(0, gp_axislv), 0, 1); break;
			
			
			case "rstick_right": if gamepad_axis_value(0, gp_axisrh) > 0 && rstick_digital_vals[RIGHT] == -1
			{
				rstick_digital_vals[RIGHT] = 0;
				return 1;	
			} else {rstick_digital_vals[RIGHT] = -1;}
			break;
			
			case "rstick_up": if gamepad_axis_value(0, gp_axisrv) < 0 && rstick_digital_vals[UP] == -1
			{
				rstick_digital_vals[UP] = 0;
				return 1;	
			} else {rstick_digital_vals[UP] = -1;}
			break;
			
			case "rstick_left": if gamepad_axis_value(0, gp_axisrh) < 0 && rstick_digital_vals[LEFT] == -1
			{
				rstick_digital_vals[LEFT] = 0;
				return 1;	
			} else {rstick_digital_vals[LEFT] = -1;}
			break;
			
			case "rstick_down": if gamepad_axis_value(0, gp_axisrv) > 0 && rstick_digital_vals[DOWN] == -1
			{
				rstick_digital_vals[DOWN] = 0;
				return 1;	
			} else {rstick_digital_vals[DOWN] = -1;}
			break;
			
			
			
			case "right": if gamepad_axis_value(0, gp_axislh) > 0 && lstick_digital_vals[RIGHT] == -1
			{
				lstick_digital_vals[RIGHT] = 0;
				return 1;	
			} else if gamepad_axis_value(0, gp_axislh) <= 0 {lstick_digital_vals[RIGHT] = -1; return 0;}
			else {return 0;}
			break;
			
			case "up": if gamepad_axis_value(0, gp_axislv) < 0 && lstick_digital_vals[UP] == -1
			{
				lstick_digital_vals[UP] = 0;
				return 1;	
			} else if gamepad_axis_value(0, gp_axislv) >= 0 {lstick_digital_vals[UP] = -1; return 0;}
			else {return 0;}
			break;
			
			case "left": if gamepad_axis_value(0, gp_axislh) < 0 && lstick_digital_vals[LEFT] == -1
			{
				lstick_digital_vals[LEFT] = 0;
				return 1;	
			} else if gamepad_axis_value(0, gp_axislh) <= 0 {lstick_digital_vals[LEFT] = -1; return 0;}
			else {return 0;}
			break;
			
			case "down": if gamepad_axis_value(0, gp_axislv) > 0 && lstick_digital_vals[DOWN] == -1
			{
				lstick_digital_vals[DOWN] = 0;
				return 1;	
			} else if gamepad_axis_value(0, gp_axislv) <= 0 {lstick_digital_vals[DOWN] = -1; return 0;}
			else {return 0;}
			break;
			

			case "lstick_btn": return gamepad_button_check(0, gp_stickl); break;
			case "rstick_btn": return gamepad_button_value(0, gp_stickr); break;
			case "enter": return gamepad_button_value(0, gp_face1); break;
			case "A": return gamepad_button_value(0, gp_face1); break;
			case "B": return gamepad_button_value(0, gp_face2); break;
			case "Y": return gamepad_button_value(0, gp_face3); break;
			case "X": return gamepad_button_value(0, gp_face4); break;
			case "start": return gamepad_button_value(0, gp_start); break;
			case "select": return gamepad_button_value(0, gp_select); break;

			case "lBumper": return gamepad_button_value(0, gp_shoulderl); break;
			case "rBumper": return gamepad_button_value(0, gp_shoulderr); break;
			case "lTrigger_pressed": return gamepad_button_check_pressed(0, gp_shoulderlb); break;
			case "trigger_click_pressed": return gamepad_button_check_pressed(0, gp_shoulderrb); break;
			case "trigger_click": return gamepad_button_check(0, gp_shoulderrb); break;
			case "lTrigger_val": return gamepad_button_value(0, gp_shoulderlb); break;
			case "rTrigger_val": return gamepad_button_value(0, gp_shoulderrb); break;
			default: return 0;
		}
	}
}

//function inp_right()
//{
//	var total = 0;
//	if right_key() == 0 && lstick_x() > 0
//	{
//		total += lstick_x();
//	} 
//	if lstick_x() == 0 || gamepad_is_connected(0) == false 
//	{
//		total += right_key();
//	} 
//	return total;
//}

//function inp_left()
//{
//	var total = 0;
//	if left_key() == 0 && lstick_x() < 0
//	{
//		total += lstick_x();
//	} 
//	if lstick_x() == 0 || gamepad_is_connected(0) == false
//	{
//		total += left_key();
//	} 
//	return total;
//}

//function inp_up()
//{
//	var total = 0;
//	if up_key() == 0 && lstick_y() < 0
//	{
//		total += lstick_y();
//	} 
//	if lstick_y() == 0 || gamepad_is_connected(0) == false
//	{
//		total += up_key();
//	} 
//	return total;
//}

//function inp_down()
//{
//	var total = 0;
//	if down_key() == 0 && lstick_y() > 0
//	{
//		total += lstick_y();
//	} 
//	if lstick_y() == 0 || gamepad_is_connected(0) == false
//	{
//		total += down_key();
//	} 
//	return total;
//}