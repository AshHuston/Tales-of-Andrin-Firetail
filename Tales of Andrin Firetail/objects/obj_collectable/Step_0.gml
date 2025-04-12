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
	var article = "a"
	if array_contains(["A","a","E","e","I","i","O","o","U","u"],string_char_at(item.name, 1)){ article = "an" }
	var text = "Picked up " + article + " " + item.name + "."
	splash_text(text, true)
	instance_destroy(self)
}