var acceptingInputs = true
image_alpha = 1
for (var i=0; i<array_length(objsThatWillPauseThis); i++){
	if instance_number(objsThatWillPauseThis[i]) > 0{
		acceptingInputs = false
		image_alpha = 0.65
		var ignoredObjects = [
			obj_inventory_menu,	
			obj_saving_indicator, 
			obj_settings_menu
			]
		if input("back") && !array_contains(ignoredObjects, objsThatWillPauseThis[i]){
			var obj = instance_find(objsThatWillPauseThis[i], 0)
			instance_destroy(obj)
		}
	}
}

if acceptingInputs {
	up_key = input("up")
	down_key = input("down")
	accept_key = input("enter")
	back_key = input("back")
	if input(triggeringInput){ instance_destroy(self) }
}else{
	up_key = false
	down_key = false
	accept_key = false
	back_key = false
}

//adjust window
height = 12 +(op_length*(20 + op_space + op_border));
 
if btn_pressed == false
	{
	if down_key{
		pos++;
		lastInput = "down"
		}
	if up_key{
		pos--;
		lastInput = "up"
		}
	if pos>=op_length{pos=0};
	if pos<0 {pos=op_length-1};
	btn_pressed = true;
	}
if !down_key && !up_key {btn_pressed = false}
if back_key{ accept_key = true; pos = 0; }

if array_contains(badOptions, pos){
	switch(lastInput){
		case "up":		pos--; break;
		case "down":	pos++; break;
	}
}else{
	lastInput = ""	
}

//Clicky da button
if (accept_key) {
	switch(pos){
		case 0:
		instance_destroy(self)
		break;
		
		case 1: //Party menu
			instance_create_depth(0,0,0, obj_party_menu)
		break;
		
		case 2: //Inventory
			instance_create_depth(0,0,0, obj_inventory_menu)
		break; 
		
		case 3: //EQ menu
			if global.ALL_GAME_FLAGS.demo.eqExplained{
				instance_create_depth(0,0,0, obj_eq_menu)
			}
		break; 
		
		case 4: //Save
			splash_text("Sorry, the save system is still in development.")
			//saveGame()
		break;
		
		case 5: //Settings menu
			//instance_create_depth(0,0,0, obj_settings_menu)
			splash_text("Sorry, no settings yet!\nPlease include in the feedback survey what settings you'd like to see added.")
		break;
		
		case 6: //main menu
			room_goto(rm_titleScreen)
		break;
	}	
}

// ---------------------------- Placement and sizing ------------------------------------------------------
//adjust window
height = (op_length*(string_height(option[0]) + op_border))+op_length*2
width = 0
for (var i=0; i<op_length; i++){
	var minTextWidth = string_width(option[i])
	if minTextWidth > width{
		width = minTextWidth
	}
}
width += op_border*2
var minMenuWidth = 50
var maxMenuWidth = 175
width = clamp(width, minMenuWidth, maxMenuWidth)

//Relocate the menu
var camXBuffer = 10
var camYBuffer = 10