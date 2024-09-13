

if place_meeting(x, y, obj_overworld_aaron){
	var aaron = instance_find(obj_overworld_aaron, 0)
	
	var testKey = {name:"testKey", 
		quantity: 1, 
		use: show_debug_message("Door Opened"), 
		description:"Opens a certain locked door", 
		}
	array_push(aaron.inventory, testKey)
	instance_destroy(self)
}