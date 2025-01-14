function getCombatPartyIDs(){
		outArr =[]
		for (var i=0;i<array_length(global.COMBATANTS);i++;){
			if object_get_parent(global.COMBATANTS[i].object_index) != obj_enemy{
			array_push(outArr, global.COMBATANTS[i]);
			}
		}
		return outArr;	
	}
