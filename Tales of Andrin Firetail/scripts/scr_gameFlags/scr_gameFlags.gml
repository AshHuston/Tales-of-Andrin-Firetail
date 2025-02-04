function getFlag(pathString){
	var steps = string_split(pathString, ".", true)
	var pointer = global.ALL_GAME_FLAGS[$ steps[0]]
	for (var i=1; i<array_length(steps); i++){
		pointer = pointer[$ steps[i]]
	}
		return pointer
}

function setFlag(pathString, value){
	var steps = string_split(pathString, ".", true)
	switch(array_length(steps)){
		case 1:
			global.ALL_GAME_FLAGS[$ steps[0]] = value
			break;
		case 2:
			global.ALL_GAME_FLAGS[$ steps[0]][$ steps[1]] = value
			break;
		case 3:
			global.ALL_GAME_FLAGS[$ steps[0]][$ steps[1]][$ steps[2]] = value
			break;
		case 4:
			global.ALL_GAME_FLAGS[$ steps[0]][$ steps[1]][$ steps[2]][$ steps[3]] = value
			break;
		case 5:
			global.ALL_GAME_FLAGS[$ steps[0]][$ steps[1]][$ steps[2]][$ steps[3]][$ steps[4]] = value
			break;
		case 6:
			global.ALL_GAME_FLAGS[$ steps[0]][$ steps[1]][$ steps[2]][$ steps[3]][$ steps[4]][$ steps[5]] = value
			break;
		
	}
}

global.ALL_GAME_FLAGS ={
	demo:{
		combatTutorialFinished: false,
		hasDiscussedRats: false,
		hasDiscussedMagicRats: false
	}
}