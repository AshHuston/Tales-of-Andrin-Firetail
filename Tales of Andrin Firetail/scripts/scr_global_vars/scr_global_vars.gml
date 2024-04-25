global.GAME_IS_PAUSED = false;
global.OVERWORLD_ID_AARON = 0;
global.OVERWORLD_ID_A = 0;
global.OVERWORLD_ID_B = 0;
global.OVERWORLD_ID_C = 0;
global.COMBAT_ORDERING = ["AARON", "A", "B", "C"];

global.COMBATANTS = [];
function getCombatPartyIDs(){
	show_debug_message(global.COMBATANTS);
		outArr =[]
		for (var i=0;i<array_length(global.COMBATANTS);i++;){
			if object_get_parent(global.COMBATANTS[i].object_index) != obj_enemy{
			array_push(outArr, global.COMBATANTS[i]);
			show_debug_message("PUSHED COMBATANAT")
			}
		}
		return outArr;	
	}
	
//global.font_main = font_add_sprite(spr_font1, 32, true, 1);;