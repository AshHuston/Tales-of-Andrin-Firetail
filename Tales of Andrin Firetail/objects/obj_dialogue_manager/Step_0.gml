charactersToType += 2;


fullLineText = dialogueBlurb.text

//Check if text is printed
if charactersToType >= string_length(fullLineText){
	charactersToType = string_length(fullLineText);
	textIsAllPrinted = true;
}