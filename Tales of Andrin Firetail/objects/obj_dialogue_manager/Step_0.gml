charactersToType += 2
options = variable_struct_get_names(dialogueBlurb.response_options)

fullLineText = dialogueBlurb.text

//Check if text is printed
if charactersToType >= string_length(fullLineText){
	charactersToType = string_length(fullLineText);
	textIsAllPrinted = true;
}



//Select hovered option
	if optionsAreDisplayed{
		//Code to select option
		hoveredOption = variable_struct_get(dialogueBlurb.response_options, options[hoveredIndex])
	
		if input("down"){
			hoveredIndex --;
		}
		if input("up"){
			hoveredIndex ++;
		}
		if hoveredIndex < 0{
			hoveredIndex = array_length(options) - 1;
		}
		if hoveredIndex == array_length(options){
			hoveredIndex = 0;
		}
	}


// Move to next dialogue step
if textIsAllPrinted && input("enter"){
	
	//Select hovered option
	if optionsAreDisplayed{
		dialogueBlurb = variable_struct_get(dialogueBlurb.response_options, options[hoveredIndex]);
		hoveredIndex = 0;
		optionsAreDisplayed = false;
	}
	else if variable_struct_names_count(dialogueBlurb.response_options) != 0{
		var key = variable_struct_get_names(dialogueBlurb.response_options)[0]
		dialogueBlurb = dialogueBlurb.response_options[$ key];
		textIsAllPrinted = false;
		charactersToType = 0;
	}
	else{
		instance_destroy(self);
	}
}