global.GAME_IS_PAUSED = false;
global.OVERWORLD_ID_AARON = 0;
global.OVERWORLD_ID_A = 0;
global.OVERWORLD_ID_B = 0;
global.OVERWORLD_ID_C = 0;
global.COMBAT_ORDERING = ["AARON", "A", "B", "C"];
global.COMBATANTS = [];
global.DEFAULT_OVERWORLD_MONSTER_BENCH = [-1000, -1000]
global.CRYSTAL_INVENTORY = []
global.EQUIPPED_CRYSTALS = []
global.PLAYER_INVENTORY = []
global.PLAYER_GOLD = 0

// Honestly idk if this is the right place for this or not. 
// Right now im more concerned with making the global work.
// It could just go in it's own script.
function getCombatPartyIDs(){
		outArr =[]
		for (var i=0;i<array_length(global.COMBATANTS);i++;){
			if object_get_parent(global.COMBATANTS[i].object_index) != obj_enemy{
			array_push(outArr, global.COMBATANTS[i]);
			}
		}
		return outArr;	
	}
