up_key = input("up");
down_key = input("down");
accept_key = input("enter");
back_key = input("back");


//Store num of options in current menu
op_length = array_length(option[menu_level]);

//adjust window
 height = 12 +(op_length*(20 + op_space + op_border));
 
//if !down_key && !up_key {btn_pressed = false}else{btn_pressed = true}
//if btn_pressed == false
//	{
		if down_key{pos++;}
		if up_key{pos--;}
		if pos>=op_length{pos=0};
		if pos<0 {pos=op_length-1};
//		btn_pressed = true;
//	}

//if  (input("down_cont") - input("up_cont")) == 0 {btn_pressed = false}

if back_key{
	menu_level = 0;
	op_length = array_length(option[menu_level]);
}
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
		
		//Attacks menu
		case 1:
			switch (pos){
				case 0:
					menu_level = 0;
					break;
					
				default:
				selectedAction = attacks[pos];
				chosenTargets = [];
				array_push(chosenTargets, selectedAction.targetID)
			}
			 
		break;
		
		//Spells menu
		case 2:
			switch (pos){
				case 0:
					menu_level = 0;
					break;
				
				default:
				selectedAction = spells[pos];
				chosenTargets = [];				 
				array_push(chosenTargets, selectedAction.targetID)
			}
		break;
		
		//Special Actions menu
		case 3:
		switch (pos){
				case 0:
					menu_level = 0;
					break;
					
				default:
				selectedAction = spells[pos];
				chosenTargets = [];				 
				array_push(chosenTargets, selectedAction.targetID)
		}
		break;
		
		//Inventory menu
		case 4:
		switch (pos){
				case 0:
					menu_level = 0;
					break;
					
				default:
				selectedAction = inventory[pos];
				chosenTargets = [];				 //Temporary line of code? // = slectedAction.cantarget
				array_push(chosenTargets, selectedAction.targetID)
		}
		break;
		
	}	
	//prep for next menu
	sel_btn_pressed_last = true;
	if _sml != menu_level{pos=0;}
	op_length = array_length(option[menu_level]);
} else {sel_btn_pressed_last = false;}

//if input("enter") {sel_btn_pressed_last = true;}

if selectedAction != {name:"empty"} && array_length(chosenTargets) != 0 {
	combatManagerID.action = selectedAction;
	combatManagerID.targets = chosenTargets;
	combatManagerID.step = "Select targets";
	//if array_contains(combatManagerID.preDesignatedTargets, chosenTargets){combatManagerID.drawSelector = false}
	instance_destroy(self);
}