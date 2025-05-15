event_inherited()

image_alpha = 100

function interact(){
	var _f = function(_element, _index){
		var result = false
		try{
			if 	_element.name == "Key"{
				result = true
			}
		}
			return result
		}
	var index = array_find_index(global.OVERWORLD_ID_AARON.inventory, _f)
	if index != -1{
		array_delete(global.OVERWORLD_ID_AARON.inventory, index, 1)
		var difX = (x-global.OVERWORLD_ID_AARON.x)*2
		var difY = (y-global.OVERWORLD_ID_AARON.y)*2
		var checkX = x + difX
		var checkY = y + difY
		var fogs[]
		for (var i = 0; i < instance_number(obj_fogOfWar); ++i;)
			{
			    fogs[i] = instance_find(obj_fogOfWar, i);
			}
		for (var i = 0; i < instance_number(obj_fogOfWar); ++i;)
			{
			    if place_meeting(checkX, checkY, fogs[i]){
					fogofwarID = fogs[i].id
				}
			}
		try{
			//instance_destroy(fogofwarID)
			//fogofwarID.fadeOut = true
		}
		instance_destroy(self)
	}else{splash_text("Door is locked", true)}
}