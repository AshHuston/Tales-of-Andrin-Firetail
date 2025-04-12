if instance_number(obj_dialogue_manager) < 1{
	try{
		if place_meeting(x, y, global.OVERWORLD_ID_AARON){
			print("Creating Dialogue")
			instance_create_depth(0, 0, 0, obj_dialogue_manager, {wholeDialogueStruct: dialogueFull})
			instance_destroy(self)
		}
	}catch(err){print(err)}
}