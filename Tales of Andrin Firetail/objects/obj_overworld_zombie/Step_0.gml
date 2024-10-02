event_inherited()

function periodicallyFlip(){
	var num
	num = random(30)
	if num <=1{ image_xscale*=-1 }
}
periodicallyFlip()


if !hasStartedCombat && place_meeting(x, y, obj_overworld_aaron){
	hasStartedCombat = true
	var quantities = [1, 1, 1, 2, 2, 2, 2, 2, 3] // One way to get a number of zombies
	var numberOfMobs = array_shuffle(quantities)[0]
	startCombat(numberOfMobs, obj_combat_zombie)
}
