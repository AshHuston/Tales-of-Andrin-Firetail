function getCombatPartyIDs(aliveOnly){
	outArr =[]
	for (var i=0;i<array_length(global.COMBATANTS);i++;){
		if object_get_parent(global.COMBATANTS[i].object_index) != obj_enemy{
		array_push(outArr, global.COMBATANTS[i]);
		}
	}
		
	if aliveOnly{
		for (var i=0;i<array_length(outArr);i++;){
			if !outArr[i].isConscious{
				print(outArr[i].combatName)
				array_delete(outArr, i, 1)
				i--
			}
		}
	}
		
	return outArr;	
}
