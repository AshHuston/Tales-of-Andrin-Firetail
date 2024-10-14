up_key = input("up");
down_key = input("down");
accept_key = input("enter");
back_key = input("back");


//Store num of options in current menu
op_length = array_length(option[menu_level]);

// Traverse the menu
if down_key{pos++}
if up_key{pos--}
if pos>=op_length{pos=0}
if pos<0 {pos=op_length-1}

// Back button
if back_key{
	menu_level = 0;
	op_length = array_length(option[menu_level]);
}
#region Press select
chosenTargets = [];	
if (accept_key) 
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


if selectedAction != {name:"empty"} && array_length(chosenTargets) != 0 {
	var cost = 0
	var type = ""
	try{
		cost = real(selectedAction.cost_value)
		type = selectedAction.cost_type
	}catch(e){
		cost = 0
		type = ""
	}
	show_debug_message("COST: " + string(cost))
	var statCurrentVal = 0
	
	switch(type){
		//@TODO If i dont remove this then ill have to work out various "seconday stats" and whatnot. 
		case "MP @TESTING PROBABLY REMOVE THIS WHOLE SWITCH CASE STATEMENT": statCurrentVal = activeCombatant.currentMana break;
	}
	statCurrentVal = activeCombatant.secondaryDisplayBarCurrent
	if  cost == 0 || statCurrentVal >= cost{
		combatManagerID.action = selectedAction;
		combatManagerID.targets = chosenTargets;
		combatManagerID.step = "Select targets";
		instance_destroy(self);
	}else{
		var shakeFrames = 15 //@TODO Fairly arbitrary number here.
		combatManagerID.shakeSecondBarFrames = shakeFrames
		selectedAction = {name:"empty"}
	}
}
#endregion

// ---------------------------- Placement and sizing ------------------------------------------------------
//adjust window
height = (op_length*(string_height(option[menu_level][0]) + op_border))+op_length*2
width = 0
for (var i=0; i<op_length; i++){
	if string_width(option[menu_level][i].name) > width{
	width = string_width(option[menu_level][i].name)
	}
}
width += op_border*2
var minMenuWidth = 50
var maxMenuWidth = 175
width = clamp(width, minMenuWidth, maxMenuWidth)

//Relocate the menu
var camXBuffer = 10
var camYBuffer = 10
//x = camX + camXBuffer
//y = camY + (camHeight/2) - camYBuffer - height/2
