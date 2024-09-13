depth = 1
image_xscale = 20/sprite_width
image_yscale = 20/sprite_height
interactable = true
image_speed = 0

function interact(){
	instance_create_depth(0, 0, 0, obj_dialogue_manager, {wholeDialogueStruct: global.DIALGUE_STRUCT})
	//show_debug_message(global.DIALGUE_STRUCT)
	//show_debug_message(json_stringify(global.DIALGUE_STRUCT_2, true))
}