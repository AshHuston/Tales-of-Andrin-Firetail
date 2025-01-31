if place_meeting(x, y, obj_overworld_aaron){
	var aaron = global.OVERWORLD_ID_AARON
	var item = itemInfo
	var addNew = true
	if variable_struct_exists(item, "stackable"){
		if item.stackable{
			for (var i=0;i<array_length(aaron.inventory);i++){
				if aaron.inventory[i].name == item.name{
					aaron.inventory[i].quantity++
					addNew = false
				}
			}
		}
	}
	
	if addNew { array_push(aaron.inventory, item) }
	
	instance_destroy(self)
}