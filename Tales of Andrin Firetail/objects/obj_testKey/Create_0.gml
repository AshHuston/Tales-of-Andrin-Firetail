event_inherited()

itemInfo = {
	name:"Key", 
	tags: ["key"],
	quantity: 1, 
	use: function text(){show_debug_message("Door Opened")}, 
	can_use: function canUse(){return false},
	description:"Opens a certain locked door", 
}