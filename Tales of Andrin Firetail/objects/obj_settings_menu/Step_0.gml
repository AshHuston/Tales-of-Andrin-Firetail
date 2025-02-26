var acceptingInputs = true

for (var i=0; i<array_length(objsThatWillPauseThis); i++){
	if instance_number(objsThatWillPauseThis[i]) > 0{ acceptingInputs = false}
}

if acceptingInputs {up_key = input("up")
down_key = input("down")
accept_key = input("enter")
//if 0.25 > gamepad_axis_value(0, gp_axislv) > -0.25 {up_down_stick = gamepad_axis_value(0, gp_axislv);}
accept_btn = gamepad_button_value(0, gp_face1);
}
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

//Clicky da button
if (accept_key) {
	switch(pos){
		case 0:
		instance_destroy(self)
		break;
		
		case 1: //Party menu
			
		break;
		
		case 2: //Inventory
			
		break; 
		
		case 3: //EQ menu
			
		break; 
		
		case 4: //Save
		
		break;
		
		case 5: //Settings menu
		
		break;
		
		case 6: //main menu
		
		break;
	}	
}