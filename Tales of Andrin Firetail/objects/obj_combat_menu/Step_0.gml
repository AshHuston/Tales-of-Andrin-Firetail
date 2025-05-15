up_key = input("up");
down_key = input("down");
accept_key = input("enter");
back_key = input("back");
if instance_exists(obj_inventory_menu){ 
	up_key     = false
	down_key   = false
	back_key   = false
	accept_key = false
	}

//Store num of options in current menu
op_length = array_length(option[menu_level]);

// Traverse the menu
if down_key{pos++}
if up_key{pos--}
if pos>=op_length+menu_min{pos=menu_min}
if pos<menu_min {pos=op_length-1}

//Back button
if back_key{
	if !instance_exists(obj_party_menu){
		menu_level = 0;
		op_length = array_length(option[menu_level]);
	}else{
		instance_destroy(instance_find(obj_party_menu,0))
		continuingOperation = false
	}
}

if instance_exists(obj_inventory_menu){ accept_key = false; }

#region Press select
if (accept_key)
{
	var _sml = menu_level;
	var back = 0
	switch(menu_level)
	{		
		case 0:
		switch(pos)
		{
		//PREVIOUS ACTION
			case -1:
			selectedAction = activeCombatant.lastUsedAction
			array_push(chosenTargets, selectedAction.targetID)
			break;
			
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
			pos = 0
			if !instance_exists(obj_inventory_menu){ instance_create_depth(0,0,0, obj_inventory_menu, {combatMenuID:id, combatManagerID:combatManagerID, activeCombatant:activeCombatant})}
			break;
		}
		break;
		
		//Attacks menu
		case 1:
			back = array_length(attacks)-1
			switch (pos){
				case back:
					menu_level = 0;
					break;
					
				default:
					selectedAction = attacks[pos];
					array_push(chosenTargets, selectedAction.targetID)
			}
			 
		break;
		
		//Spells menu
		case 2:
			back = array_length(spells)-1
			switch (pos){
				case back:
					menu_level = 0;
					break;
				
				default:
					selectedAction = spells[pos];			 
					array_push(chosenTargets, selectedAction.targetID)
			}
		break;
		
		//Special Actions menu
		case 3:
			back = array_length(specialActions)-1
			switch (pos){
				case back:
					menu_level = 0;
					break;
					
				default:
					selectedAction = specialActions[pos];	 
					array_push(chosenTargets, selectedAction.targetID)
		}
		break;
		
		//Inventory menu
		case 4:
			if !instance_exists(obj_inventory_menu){ instance_create_depth(0,0,0, obj_inventory_menu, {combatManagerID:combatManagerID, activeCombatant:activeCombatant})}
		break;		
	}	
	//prep for next menu
	sel_btn_pressed_last = true;
	if _sml != menu_level{pos=0;}
	op_length = array_length(option[menu_level]);
} else {sel_btn_pressed_last = false;}

#region Hovered action manager
var menuToRead = []
switch(menu_level)
	{
	case 1:
		menuToRead = attacks; break;
		
	case 2:
		menuToRead = spells; break;
		
	case 3:
		menuToRead = specialActions; break;
		
	case 4: //Inventory
		//This one needs to be figured out. It may be left blank and handled in the inventory menu.
	break;		
}	

switch (menu_level){
	case 0:
		if pos == -1{
			combatManagerID.hoveredAction = activeCombatant.lastUsedAction
		}else{
			combatManagerID.hoveredAction = {name:"none"}; 
		}
		break;
	default:
		combatManagerID.hoveredAction = menuToRead[pos];
}
#endregion

if combatManagerID.hoveredAction.name != "none" {checkActionForVariables(combatManagerID.hoveredAction)}

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
	var statCurrentVal = 0
	
	
	statCurrentVal = activeCombatant.secondaryDisplayBarCurrent
	if  cost == 0 || statCurrentVal >= cost{
		combatManagerID.action = variable_clone(selectedAction);
		combatManagerID.targets = chosenTargets;
		combatManagerID.step = "Select targets";
		combatManagerID.hoveredAction = {name:"none"};
		try{ 
			if instance_exists(combatManagerID.targets[0]) { 
				combatManagerID.step = "Do action"; 
			}
		}catch(err){}
		instance_destroy(self);
		instance_destroy(instance_find(obj_inventory_menu, 0))
	}else{
		var shakeFrames = 15 //@TODO Fairly arbitrary number here.
		combatManagerID.shakeSecondBarFrames = shakeFrames
		selectedAction = {name:"empty"}
		chosenTargets = []
	}
}
#endregion



// ---------------------------- Placement and sizing ------------------------------------------------------
//adjust window
height = (op_length * op_space)+op_border

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
x = xBase
y = yBase - (height/2)

seperator = 3 //Redundant line for legibikity
descriptionX = xBase + width + seperator
descriptionY = y