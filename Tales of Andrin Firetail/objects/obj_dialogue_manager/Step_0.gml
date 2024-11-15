function hasAnyValues(struct){
	var keys = struct_get_names(struct)
	var has_values = false
	for (var i = 0; i<array_length(keys); i++;){
		//var key = keys[i]
		if (string(struct[$ keys[i]]) != "NaN"){ 
			has_values = true 
			//show_debug_message(string(struct[$ keys[i]]))
			}
	}
	return has_values
}

charactersToType += 2
options = variable_struct_get_names(dialogueBlurb.response_options)

fullLineText = dialogueBlurb.text

switch (dialogueBlurb.voiceoverID){
	case "":
	case "none":
	case "nothing":
	case "silence":
		voiceover =  asset_get_index("snd_dialogue_silence")
		//show_debug_message(getDialogue("testjson"))
		break;
	default:
		voiceover = asset_get_index("snd_dialogue_"+dialogueBlurb.voiceoverID)
}

if audio_is_playing(previousVoiceOver){
	audio_stop_sound(previousVoiceOver)
}


if playVoiceover{
	audio_play_sound(voiceover, 1, false)	
	playVoiceover = false
}

//Check if text is printed
if charactersToType >= string_length(fullLineText){
	charactersToType = string_length(fullLineText);
	textIsAllPrinted = true;
	stopYappingDelay += 1
}


if textIsAllPrinted == false && input("enter"){
	charactersToType = string_length(fullLineText)
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
	
	continueIndicatorAnimationFrame = 0
	animationFrame = 0
	stopYappingDelay = 0
	playVoiceover = true
	previousVoiceOver = voiceover
	
	//Select hovered option
	if optionsAreDisplayed{
		dialogueBlurb = variable_struct_get(dialogueBlurb.response_options, options[hoveredIndex]);
		hoveredIndex = 0;
		textIsAllPrinted = false;
		charactersToType = 0;
		optionsAreDisplayed = false;
	}
	else if hasAnyValues(dialogueBlurb.response_options){
		//var key = variable_struct_get_names(dialogueBlurb.response_options)[0]
		//dialogueBlurb = dialogueBlurb.response_options[$ key];["response_1"
		dialogueBlurb = dialogueBlurb.response_options.response_1
		textIsAllPrinted = false;
		charactersToType = 0;
	}
	else{
		instance_destroy(self);
	}
}