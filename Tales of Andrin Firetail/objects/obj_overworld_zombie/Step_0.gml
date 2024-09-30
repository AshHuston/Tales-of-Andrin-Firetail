event_inherited()

function periodicallyFlip(){
	var num
	num = random(30)
	if num <=1{ image_xscale*=-1 }
}
periodicallyFlip()


if place_meeting(x, y, obj_overworld_aaron){
	var quantities = [1, 1, 1, 2, 2, 2, 2, 2, 3] //Arbitrary way to get a possible number of zombies
	var numberOfMobs = array_shuffle(quantities)[0]
	startCombat(numberOfMobs, obj_combat_zombie)
	var Z1;	
	var Z2;
	var Z3;	
	var Z4;
	var Z5;
	if !instance_exists(obj_combat_zombie){
		Z1 = instance_create_depth(0,0,0,obj_combat_zombie);
		Z2 = instance_create_depth(0,0,0,obj_combat_zombie);
		Z3 = instance_create_depth(0,0,0,obj_combat_zombie);
		Z4 = instance_create_depth(0,0,0,obj_combat_zombie);
		Z5 = instance_create_depth(0,0,0,obj_combat_zombie);
		instance_create_depth(0,0,0,obj_combat_manager, {
			overworld_mob:id, 
			mob1: Z1, 
			mob2: Z2,
			mob3: Z3,
			mob4: Z4,
			mob5: Z5
			})
	}
}
