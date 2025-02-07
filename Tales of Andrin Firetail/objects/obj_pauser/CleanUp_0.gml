updateSavedStats()
if instance_number(obj_pauser) == 1{
	global.GAME_IS_PAUSED = false
}

/*
print(object_get_name(object_index) + " deleted")
print("Remaining pausers:")

for (var i=0; i<instance_number(obj_pauser); i++){
	
	print(object_get_name(instance_find(obj_pauser, i).object_index))
}
print("-----------------------")
*/