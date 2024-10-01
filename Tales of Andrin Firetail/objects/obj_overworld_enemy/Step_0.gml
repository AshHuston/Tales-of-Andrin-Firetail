function benchThisMonster(){
	x = global.DEFAULT_OVERWORLD_MONSTER_BENCH[0]
	y = global.DEFAULT_OVERWORLD_MONSTER_BENCH[1]	
}

function startCombat(numberOfMonsters, certainMonsters, possibleMonsters=[]){
	numberOfMonsters = clamp(numberOfMonsters, 1, 5)
	benchThisMonster()
	if typeof(certainMonsters) != "array" {certainMonsters = [certainMonsters]}
	if array_length(possibleMonsters) == 0 {array_copy(possibleMonsters, 0, certainMonsters, 0, array_length(certainMonsters))}
	mobs = [noone, noone, noone, noone, noone]
	for (var i = 0; i<numberOfMonsters; i++){
		if i<array_length(certainMonsters){
			mobs[i] = instance_create_depth(0,0,0,certainMonsters[i])
		}else{
			possibleMonsters = array_shuffle(possibleMonsters)
			mobs[i] = instance_create_depth(0,0,0,possibleMonsters[0])
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