//show_debug_message("Current coords: ------ " + string(x) + ", " + string(y))
//show_debug_message("Destinatio ncoords: -- " + string(destinationCoords[0]) + ", " + string(destinationCoords[1]))
//show_debug_message("")

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
			try{
				if target.interactable == true{
					target.interact()	
				}
			}
		}
}

if global.OVERWORLD_ID_AARON != id{global.OVERWORLD_ID_AARON = id;}

//Check for instance of combat object. if none, make one.
if !instance_exists(obj_combat_aaron){
	//instance_create_depth(x,y,0,obj_combat_aaron);
}


if !instance_exists(obj_combat_manager) && framecount >= 40{
	instance_create_depth(x,y,0,obj_combat_manager, {mob1:instance_find(obj_enemy, 0), mob2:instance_find(obj_enemy, 1), mob3:instance_find(obj_enemy, 2), mob4:instance_find(obj_enemy, 3), mob5:instance_find(obj_enemy, 4)});
}
//Spawns combat manager \/
//framecount++

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

paused = global.GAME_IS_PAUSED