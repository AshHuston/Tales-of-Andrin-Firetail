if isInSelectionMode{
	#region menu traversal
	up_key = input("up")
	down_key = input("down")
	accept_key = input("enter")
	right_key = input("right")
	left_key = input("left")
	back_key = input("back");
	var prevSelectedIndex = selectionIndex
	if right_key{X++}
	if left_key{X--}
	if down_key{Y++}
	if up_key{Y--}
	if X==2{X = 0}
	if Y==2{Y = 0}
	if X==-1{X = 1}
	if Y==-1{Y = 1}
	var coords = [X,Y]
	var one = [0,0]
	var two = [0,1]
	var three = [1,0]
	var four = [1,1]
	switch(array_length(party)){ //Set the selection index
		case 1:
			selectionIndex = 0
		break;
		case 2:
			selectionIndex = 0+Y 
		break;
		case 3:
			if array_equals(coords, one)  { selectionIndex = 0 }
			if array_equals(coords, two)  { selectionIndex = 1 }
			if array_equals(coords, three){ selectionIndex = 2 }
		break;
		case 4:
			if array_equals(coords, one)  { selectionIndex = 0 }
			if array_equals(coords, two)  { selectionIndex = 1 }
			if array_equals(coords, three){ selectionIndex = 2 }
			if array_equals(coords, four ){ selectionIndex = 3 }
		break;
	}
	
	//Ensure the hover is legal, if not, revert to the last one.
	if coords != prevCoords{
		var presetCoords = [
		string(one), 
		string(two), 
		string(three), 
		string(four)
		]
		var legalCoords = []
		array_copy(legalCoords, 0, presetCoords, 0, array_length(party))
		if !array_contains(legalCoords, string(coords)){
			X = prevCoords[0];
			Y = prevCoords[1]; 
			//shakeSelector()
		}
	}
	prevCoords = [X,Y]
	#endregion
	hoveredCharacterId = party[selectionIndex]
	if accept_key { selectedCharacterId = hoveredCharacterId }
	if back_key { closeWhenAccurate = true; closeOutFrameDelay = 1}//@DIAL Arbitrary 1 frame delay here to test feel.
}


for (var i=0; i<array_length(displayVals); i++){
	displayVals[i].currentHp = party[i].currentHp
	displayVals[i].currentOtherBar = party[i].secondaryDisplayBarCurrent
}


var barFillSpeed = 2 //@DIAL ? Will update value in a few lines
var barsWereAdjusted = false
for (var i=0; i<array_length(displayVals); i++){
	barFillSpeed = party[i].maxHp/20 // 5% of the bar per frame. 20 frames total.
	if displayVals[i].displayHp < displayVals[i].currentHp {
		displayVals[i].displayHp += barFillSpeed
		barsWereAdjusted = true
		}
	if displayVals[i].displayHp > displayVals[i].currentHp { 
		displayVals[i].displayHp -= barFillSpeed
		barsWereAdjusted = true
		}
	displayVals[i].displayHp = round(displayVals[i].displayHp)+1
	displayVals[i].displayHp = clamp(displayVals[i].displayHp, 0, displayVals[i].currentHp)
	
	barFillSpeed = party[i].secondaryDisplayBarMax/20 // 5% of the bar per frame. 20 frames total.
	if displayVals[i].displayOtherBar < displayVals[i].currentOtherBar { 
		displayVals[i].displayOtherBar += barFillSpeed
		barsWereAdjusted = true
		}
	if displayVals[i].displayOtherBar > displayVals[i].currentOtherBar { 
		displayVals[i].displayOtherBar -= barFillSpeed
		barsWereAdjusted = true
		}
	displayVals[i].displayOtherBar = round(displayVals[i].displayOtherBar)+1
	displayVals[i].displayOtherBar = clamp(displayVals[i].displayOtherBar, 0, displayVals[i].currentOtherBar)
}

if closeWhenAccurate && !barsWereAdjusted{
	if closeOutFrameDelay == 0{
		instance_destroy(self)	
	}
	closeOutFrameDelay--
}