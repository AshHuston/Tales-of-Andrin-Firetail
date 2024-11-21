var doneDrawing = true
for (var i=0; i<array_length(displayVars); i++;){
	var text = displayVars[i]
	if text.displayed{
		var framesUntilFaded = 30/raiseSpeed
		var alpha = (framesUntilFaded/(anchor[1]-displayVars[i].Y))*0.7
		if alpha>=0.3{
			draw_text_color(text.X, text.Y, text.text, c_white, c_white, c_white, c_white, alpha)
			doneDrawing = false
		}
	}
}

if doneDrawing{
	instance_destroy(self)
	}