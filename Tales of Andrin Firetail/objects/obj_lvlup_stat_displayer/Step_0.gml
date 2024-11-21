for (var i=0; i<array_length(displayVars); i++;){
	if displayVars[i].displayed {
		displayVars[i].Y -= raiseSpeed	
	}else if framesSinceLastStat >= framesBetweenStats{
		displayVars[i].displayed = true
		framesSinceLastStat = 0
	}
}

framesSinceLastStat++