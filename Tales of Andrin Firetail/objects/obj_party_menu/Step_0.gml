if isInSelectionMode{
	#region menu traversal
	// I feel like this should operate as a matrix 
	// rather than a list but its fine for the demo.
	up_key = input("up")
	down_key = input("down")
	accept_key = input("enter")
	right_key = input("right")
	left_key = input("left")
	back_key = input("back");
	if up_key {selectionIndex-=2}
	if down_key {selectionIndex+=2}
	if left_key {selectionIndex--}
	if right_key {selectionIndex++}
	if selectionIndex>=array_length(party){selectionIndex = 0}
	if selectionIndex<0{selectionIndex = array_length(party)-1}
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

//if closeWhenAccurate{print("Closing")}