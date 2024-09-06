fadeOut = false
/*
//Fades out if contacting a fading FOW
var allFOWs[]
var total = instance_number(obj_fogOfWar)
var touchingFadeout = false
for (var i = 0; i<total; i++){
	var checkFOW = instance_find(obj_fogOfWar, i)
	if (checkFOW.fadeOut == true) && (place_meeting(x, y, checkFOW)){
		fadeOut = true
		touchingFadeout = true
	}
}
if touchingFadeout == false{
		fadeOut = false
}
*/

//Fades out when contacting player
if place_meeting(x, y, global.OVERWORLD_ID_AARON){
	fadeOut = true	
}


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