function hasAnyValues(struct){
	var keys = struct_get_names(struct)
	var has_values = false
	for (var i = 0; i<array_length(keys); i++;){
		if (string(struct[$ keys[i]]) != "NaN"){ 
			has_values = true 
			}
	}
	return has_values
}

if pauseFrames == 0 {charactersToType += typeSpeed}

fullLineText = dialogueBlurb.text + "    "
#region option setup
options = variable_struct_get_names(dialogueBlurb.response_options)
for (var i = array_length(options)-1; i>=0; i--;){
	var option = variable_struct_get(dialogueBlurb.response_options, options[i])
	if typeof(option) == "number"{
		array_delete(options, i, 1)
	}
}
#endregion

#region Voiceover stuff
switch (dialogueBlurb.voiceover_id){
	case "":
	case "none":
	case "nothing":
	case "silence":
		voiceover =  asset_get_index("snd_dialogue_silence")
		break;
	default:
		voiceover = asset_get_index("snd_dialogue_"+dialogueBlurb.voiceover_id)
}

if audio_is_playing(previousVoiceOver){
	audio_stop_sound(previousVoiceOver)
}

if playVoiceover{
	try{audio_play_sound(voiceover, 1, false)}catch(err){}
	playVoiceover = false
}
#endregion

#region Gameflags
if dialogueBlurb.flag_id != ""{
	setFlag(dialogueBlurb.flag_id, dialogueBlurb.flag_value)	
}
#endregion


checkIfAllPrinted()

if textIsAllPrinted == false && input("enter"){
	charactersToType = string_length(fullLineText)
}

#region Select hovered option
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
#endregion

#region Move to next dialogue step
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
#endregion