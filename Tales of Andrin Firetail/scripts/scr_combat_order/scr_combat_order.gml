/**
 * Swaps the two character spots in the player party order.
 * @param {string} firstCharacter The first character position to swap.
 * @param {string} secondCharacter The second character position to swap
 * @returns {bool} True if sucessfully swapped two slots. False if it failed.
 */
function swapCombatSpot(firstCharacter, secondCharacter){
	
	var originalState = global.COMBAT_ORDERING;
	var itemsMoved = 0;
	
	for(var i=0; i<array_length(global.COMBAT_ORDERING); i++;){
		if global.COMBAT_ORDERING[i] == firstCharacter{
			global.COMBAT_ORDERING[i] = secondCharacter;
		}else if global.COMBAT_ORDERING[i] == secondCharacter{
				global.COMBAT_ORDERING[i] = firstCharacter
				}
		
		if originalState[i] != global.COMBAT_ORDERING[i]{
			itemsMoved++;
		}
	}
	
	if itemsMoved == 2{
		return true;
	}else{
		return false;
	}
}