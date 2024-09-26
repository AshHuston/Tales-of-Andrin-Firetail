if place_meeting(x, y, obj_overworld_aaron){
	var aaron = global.OVERWORLD_ID_AARON
	var item = itemInfo
	show_debug_message(aaron.skillRanged)
	array_push(aaron.crystal_inventory, item)
	instance_destroy(self)
}