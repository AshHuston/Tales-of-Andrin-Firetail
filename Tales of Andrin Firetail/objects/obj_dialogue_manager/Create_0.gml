event_inherited()

draw_set_font(global.font_main);

dialogueBlurb = wholeDialogueStruct.dialogue;
charactersToType = 1;
textIsAllPrinted = false
fullLineText = 0
optionsAreDisplayed = false
options = []
hoveredIndex = 0
hoveredOption = {}
animationFrame = 0
continueIndicatorAnimationFrame = 0
stopYappingDelay = 0
playVoiceover = true
maximumCharactersPerPage = 350
voiceover = snd_dialogue_silence
previousVoiceOver = snd_dialogue_silence
pauseFrames = 0

typeSpeed = 3 ///////////////////////////////////@DIAL Should be plugged into a setting probably.

setTopDepth(id)

function checkIfAllPrinted(){
	textIsAllPrinted = false
	if charactersToType >= string_length(fullLineText){
		charactersToType = string_length(fullLineText);
		textIsAllPrinted = true;
		stopYappingDelay += 1
	}
}

function trimToSlowChar(currentText){
	var wouldType = string_copy(currentText, string_length(currentText)-typeSpeed, typeSpeed)
	var stopChars = [",",".","?","!",";"]
	var removedCharCount = 0
	var foundOne = false
	for(var i=1; i<=string_length(wouldType); i++){
		if array_contains(stopChars, string_char_at(wouldType, i)) && removedCharCount == 0{ 
			removedCharCount = string_length(wouldType)-i+1; 
			foundOne = true
		}
	}
	
	if removedCharCount >= string_length(wouldType) { removedCharCount = string_length(wouldType)-1; }// minimum of 1 remaining char.
	
	var willType = string_copy(currentText, 1, string_length(currentText)-removedCharCount)
	charactersToType -= removedCharCount
	
	if foundOne{ pauseFrames = 10 } //@DIAL This should probably be a function of the typespeed and the character in question but idk what that means yet.
		
	return willType
}





function getNextFrameTypeSpeed(currentText){
	var typedLastFrame = string_copy(currentText, string_length(currentText) - charsThisFrame + 1, charsThisFrame)
	print(typedLastFrame)
	var speedSetting = 2 //@TODO Should get this value from settings. Placeholder rn. Maybe
	var typeSpeed = speedSetting
	
	
	while true{ 
		 if array_contains(stopChars, string_copy(currentText, string_length(currentText) - charsThisFrame + 1, charsThisFrame)){
		 charactersToType-- 
		 charsThisFrame--
		 }else{ break; }
	}
	
	//for(var i=1; i<=string_length(typedLastFrame); i++){
	//	if string_char_at(typedLastFrame, i)
	//}
	
	
	for(var i=1; i<=string_length(typedLastFrame); i++){
		print(string_char_at(typedLastFrame, i))
		switch(string_char_at(typedLastFrame, i)){ //This isn't reducing the speed in a noticable way, it probably just needs to be cranked up to 11.
			case ",":
				pauseFrames = 10
			break;
		
			case ".":
			case "?":
			case "!":
				pauseFrames = 40
			break;
			default:
		}
	}
	
	print(typeSpeed)
	print("-------------------")
	return typeSpeed
}