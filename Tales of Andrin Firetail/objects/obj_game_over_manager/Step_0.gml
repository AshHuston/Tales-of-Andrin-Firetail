#region GAME OVER text
function getTextSpeed(current, target){
	var diff = abs(target-current)
	var curveHeight = 1.5	//@DIAL Lower = less deceleration
	var startSpd = 7		//@DIAL Lower = faster
	return power(diff, 1/curveHeight)/startSpd
}

if textY < textTarget[Y]{
	textMoveSpeed = getTextSpeed(textY, textTarget[Y])
	textY += textMoveSpeed
}

if backgroundAlpha < maxAlpha{ backgroundAlpha += alphaSpeed }
if backgroundAlpha > maxAlpha{ backgroundAlpha = maxAlpha }
#endregion

#region Menu
var popUpSpeed = 5	// This techically sets the distance in pixels of the GameOver
					// text to its destination that will trigger the menu to popUp.
if abs(textY-textTarget[Y]) < 25{ displayOptions = true }

if displayOptions{
	//Inputs
	var up_key = input("up")
	var down_key = input("down")
	var accept_key = input("enter")
 
	//control menu
	if btn_pressed == false{
			if down_key{pos++;}
			if up_key{pos--;}
			if pos>=menuLength{pos=0};
			if pos<0 {pos=menuLength-1};
			btn_pressed = true;
		}
	if !down_key && !up_key {btn_pressed = false}
	
	//list menu options/effects
	if accept_key{
		switch(pos){
			// Load from last save
			case 0: 
				var manager = instance_find(obj_combat_manager, 0)
				instance_destroy(manager)
				loadGame()
				break;
			// Exit to menu
			case 1:
				for (var i=0; i<instance_number(obj_pauser); i++){
					instance_destroy(instance_find(obj_pauser, i))
				}
				room_goto(rm_titleScreen)
				break;
			
		}
	}
		
}
#endregion