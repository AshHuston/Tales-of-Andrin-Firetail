function benchThisMonster(){
	x = global.DEFAULT_OVERWORLD_MONSTER_BENCH[0]
	y = global.DEFAULT_OVERWORLD_MONSTER_BENCH[1]	
}

function startCombat(numberOfMonsters, certainMonsters, possibleMonsters=[]){
	show_debug_message(typeof(certainMonsters))
	benchThisMonster()
	if typeof(certainMonsters) != "array" {certainMonsters = [certainMonsters]}
	mobs = ["", "", "", "", ""]
	for (var i = 0; i<array_length(numberOfMonsters); i++){
		if i<array_length(certainMonsters){
			// ------------------------------------------ @TODO finish this function
		}else{
			
		}
	}
	
	instance_create_depth(0,0,0,obj_combat_manager, {
			overworld_mob:id, 
			mob1: mobs[0], 
			mob2: mobs[1], 
			mob3: mobs[2], 
			mob4: mobs[3], 
			mob5: mobs[4], 
			})
}