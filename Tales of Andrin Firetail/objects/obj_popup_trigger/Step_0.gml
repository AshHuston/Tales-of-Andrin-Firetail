if instance_number(obj_pauser) < 1 && getFlag("demo.readyForMovementPopup"){
	try{
		if place_meeting(x, y, global.OVERWORLD_ID_AARON){
			print("Creating popup")
			splash_text(text)
			instance_destroy(self)
		}
	}catch(err){print(err)}
}
