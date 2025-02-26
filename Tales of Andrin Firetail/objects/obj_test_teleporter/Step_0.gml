if targetRm = noone{ targetRm = rm_test_overworld }

if place_meeting(x, y, obj_overworld_aaron){
	if !lastFrameContact{ room_goto(targetRm) }
}else{ lastFrameContact = false }