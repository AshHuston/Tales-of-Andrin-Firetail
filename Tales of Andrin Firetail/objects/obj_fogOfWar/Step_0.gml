
if fadeOut == true{
	if image_alpha>0{
		image_alpha	-= fade_speed
	}
	else{
		image_alpha = 0
	}
}
else{
	if image_alpha<1{
		image_alpha	+= fade_speed
	}
	else{
		image_alpha = 1
	}	
}


//Only clears when player is there.
if place_meeting(x, y, global.OVERWORLD_ID_AARON){
	fadeOut = true	
}
else{
	fadeOut = false	
}