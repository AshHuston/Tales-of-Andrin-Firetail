if place_meeting(x, y, obj_overworld_aaron){
	var aaron = global.OVERWORLD_ID_AARON
	var item = itemInfo
	array_push(aaron.crystal_inventory, item)
	if !global.ALL_GAME_FLAGS.demo.eqExplained{
		global.ALL_GAME_FLAGS.demo.eqExplained = true
		var button = gamepad_is_connected(0)? "\"Y\"":"\"I\"";
		splash_text("Ephrin's Queen is an artifact that can channel the power of these crystals.\nCheck it out in the menu by pressing "+button+"!")
	}
	instance_destroy(self)
}