//EQ Menu testing
if input("E"){
	saveGame()
	/*
	if instance_number(obj_eq_menu) == 0{
		instance_create_depth(0,0,depth-1,obj_eq_menu)
	}else{
		instance_destroy(instance_find(obj_eq_menu,0))
		#region EQ Stats
		for(var i=0; i<array_length(activeEffects); i++){
			if activeEffects[i].effectSource == "Ephrin's Queen"{
				array_delete(activeEffects, i, 1)
				i--
			}
		}	
		for(var i=0; i<array_length(global.EQUIPPED_CRYSTALS); i++){
			if global.EQUIPPED_CRYSTALS[i].effectType == "buff"{
				array_push(activeEffects, global.EQUIPPED_CRYSTALS[i].effect)
			}
		}
		#endregion
	show_debug_message("set vals")
	}
	*/
}

//Party menu testing. Arbitrary button rn.
if input("Y"){
	instance_create_depth(x, y, 0, obj_lvlup_stat_displayer,{name:name, anchor:[x,y]})
	if instance_number(obj_party_menu) == 0{
		instance_create_depth(0,0,depth-1,obj_party_menu)
	}else{
		instance_destroy(instance_find(obj_party_menu,0))
	}
}

function moveSprite(directionToMove){
		acceptingMovementCommand = false
		deltaX = 0
		deltaY = 0
		switch(directionToMove){
			case(RIGHT):
				deltaX = movementspacesize
				break;
			
			case(DOWN):
				deltaY = movementspacesize
				break;
				
			case(LEFT):
				deltaX = -movementspacesize
				break;
				
			case(UP):
				deltaY = -movementspacesize
				break;
		}
		
		prevDestinationX = destinationCoords[0]
		prevDestinationY = destinationCoords[1]
		if place_meeting(prevDestinationX+deltaX, prevDestinationY+deltaY, obj_wall) == false{
			
			destinationCoords = [prevDestinationX+deltaX, prevDestinationY+deltaY]
		}
}

function interact(){
	var checklocation = {"xcoord":0, "ycoord":0}
	switch(facingDir){
			case(RIGHT):
				checklocation = {"xcoord":x+movementspacesize, "ycoord":y}
				break;
			
			case(DOWN):
				checklocation = {"xcoord":x, "ycoord":y+movementspacesize}
				break;
				
			case(LEFT):
				checklocation = {"xcoord":x-movementspacesize, "ycoord":y}
				break;
				
			case(UP):
				checklocation = {"xcoord":x, "ycoord":y-movementspacesize}
				break;
		}
	
		var target = instance_place(checklocation.xcoord, checklocation.ycoord, all)
		if target != noone{
			if variable_instance_exists(target, "interactable"){
				//show_debug_message(object_get_name(target.object_index))
				if target.interactable == true{
					target.interact()	
				}
			}
		}
}

#region Movement
if !paused{
	if input("enter"){ 
		interact()
	}
	if acceptingMovementCommand{
		if (input("right_cont")||input("right")) && (!input("left_cont")||input("left")){
			moveSprite(RIGHT)
			facingDir = RIGHT
			}
	
		if (input("down_cont")||input("down")) && (!input("up_cont")||input("up")){
			moveSprite(DOWN)
			facingDir = DOWN
			}
	
		if (input("left_cont")||input("left")) && (!input("right_cont")||input("right")){
			moveSprite(LEFT)
			facingDir = LEFT
			}
	
		if (input("up_cont")||input("up")) && (!input("down_cont")||input("down")){
			moveSprite(UP)
			facingDir = DOWN
			}
	}
}

if  destinationCoords[0] != x || destinationCoords[1] != y{
	notAtDestination = true
	var stepLength = movementSpeed
	if point_distance(x, y, destinationCoords[0], destinationCoords[1]) < movementSpeed{
		stepLength = 1	
	}
	if y - destinationCoords[1] > 0{ y -= stepLength}
	if y - destinationCoords[1] < 0{ y += stepLength}
	if x - destinationCoords[0] > 0{ x -= stepLength}
	if x - destinationCoords[0] < 0{ x += stepLength}
}else{
	notAtDestination = false
}

if point_distance(x, y, destinationCoords[0], destinationCoords[1]) <10 {
	acceptingMovementCommand = true
	}


if facingDir == RIGHT{
	image_xscale = -manualImageScaleX
}

if facingDir == LEFT{
	image_xscale = manualImageScaleX
}

if lastX == x && lastY == y {image_index = 0}
lastX = x
lastY = y
#endregion

#region Pausing
if global.OVERWORLD_ID_AARON != id{global.OVERWORLD_ID_AARON = id;}
paused = global.GAME_IS_PAUSED
#endregion