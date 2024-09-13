event_inherited()

draw_set_font(global.font_main);

dialogueBlurb = wholeDialogueStruct.dialogue;
charactersToType = 0;
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

for (var i = 0; i<instance_count; i++){
	var checkDepth = instance_id_get(i).depth
	if checkDepth < depth{ 
		depth = checkDepth-1
		}	
}