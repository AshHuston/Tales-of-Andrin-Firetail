function removeItemFromInventory(item){
	// Should remove 1x of the "item" from the original inventory.
	var inventory =  global.OVERWORLD_ID_AARON.inventory
	for (var i=0; i<array_length(inventory); i++){
		if item.name == inventory[i].name{
			print(item.name)
			if inventory[i].quantity > 1 { 
				inventory[i].quantity--
				print("Minus 1")
			}
			else{ 
				array_delete( inventory, i, 1)
				print("Rem from invetory")
			}
		}	
	}
	// Update inv here
	getItemsFromAaron()
}


up_key = false
down_key = false
accept_key = false
back_key = input("back");
// Pause menu interaction if awaiting result from a char-select submenu
if !instance_exists(obj_party_menu){
	up_key = input("up");
	down_key = input("down");
	accept_key = input("enter");
}

//Store num of options in current menu
op_length = array_length(option[menu_level]);

// Traverse the menu
if down_key{pos++}
if up_key{pos--}
if pos>=op_length{pos=0}
if pos<0 {pos=op_length-1}


// Back button
if back_key{
	if !instance_exists(obj_party_menu){
		if menu_level == 0 { instance_destroy(self) }
		menu_level = 0;
		op_length = array_length(option[menu_level]);
	}else{
		instance_destroy(instance_find(obj_party_menu,0))
		continuingOperation = false
	}
}
#region Press select	
if (accept_key) || (continuingOperation)
{
	var _sml = menu_level;
	switch(menu_level)
	{
		//pause menu
		case 0:
		switch(pos)
		{
		// Consumables
			case 0:
			menu_level = 1;
			break;
	
		// Equipment
			case 1:
			menu_level = 2;
			break;
		
		// Key Items	
			case 2:
			menu_level = 3;
			break;
		
		// Other
			case 3:
			menu_level = 4;
			break;
		
		//NOTHING		
			case 4:
		
			break;
		}
		break;
// ***************** BELOW NEEDS TO BE CHANGED TO MANAGE ITEM USAGE
		// Consumables
		case 1:
			if pos == 0{ menu_level = 0 }
			else{
				selectedPartyMember = "	"
				selectedItem = consumables[pos]
				continuingOperation = true
				
				// Open a menu to select which party member to target.
				// Maybe should technically check ifthe item even needs me to do this
				var charSelectMenu = 0
				if instance_number(obj_party_menu) == 0{
					charSelectMenu = instance_create_depth(x, y, 0, obj_party_menu, {isInSelectionMode: true})
				}else{ charSelectMenu = instance_find(obj_party_menu, 0) }
			
				// Wait for selection to be made.
				if charSelectMenu.selectedCharacterId != 0{
					var can_use = false
					var target = charSelectMenu.selectedCharacterId
					try{ can_use = selectedItem.can_use(target) }catch(err){print(err)}
					if can_use{	
						if combatMenuID != 0{ 
							selectedAction = selectedItem
							selectedAction.targetID = target
							array_push(combatMenuID.chosenTargets, selectedAction.targetID)
							combatMenuID.selectedAction = selectedAction					
						}else{ 
							selectedItem.use(charSelectMenu.selectedCharacterId)
							splash_text("Used " + selectedItem.name)
						}
					
						removeItemFromInventory(selectedItem)
						charSelectMenu.closeWhenAccurate = true
						pos = 0
						continuingOperation = false
					}else{
						charSelectMenu.shakeSelector()
						charSelectMenu.selectedCharacterId = 0
					}
				}
				//if charSelectMenu.closeWhenAccurate{continuingOperation = false}
			}
		break;
		
		// Equipent
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
		
		// Key Items
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
		
		// Other
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



// ---------------------------- Placement and sizing ------------------------------------------------------
//adjust window
height = (op_length * op_space)+op_border

width = 0
for (var i=0; i<op_length; i++){
	var minTextWidth = string_width(option[menu_level][i].name+" x10")
	if minTextWidth > width{
		width = minTextWidth
	}
}
width += op_border*2
var minMenuWidth = 50
var maxMenuWidth = 175
width = clamp(width, minMenuWidth, maxMenuWidth)

