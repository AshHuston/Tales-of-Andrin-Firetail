function getSpeakerSprite(){
	var speakerName = dialogueBlurb.speaker;
	var allSprites = wholeDialogueStruct.chatSpriteIDs;
	var spriteIndex = ""
	for (var i = 0; i<array_length(allSprites); i++;){
		if allSprites[i].name == speakerName{
			spriteIndex = allSprites[i].spriteID;	
		}
	}
	return spriteIndex;	
}

//Draw the text box
var textBoxX = camera_get_view_x(camera_get_active()) + 350
var textBoxY = camera_get_view_y(camera_get_active()) + 185
var textboxWidth = 300
var textboxHeight = 125
draw_sprite_ext(sprite_index, 0, textBoxX, textBoxY, textboxWidth/sprite_width, textboxHeight/sprite_height, 0, c_white, 1);


//-------------- Display speaker ---------------------
// Display speaker name
var speaker = dialogueBlurb.speaker;
var header = string_concat(speaker, "\n", "------", "\n")
fullLineText = string_concat(header, fullLineText)

// Display speaker sprite
var speakerSprite = getSpeakerSprite()


//------------- Draw text ---------------------
//Write text
var textBonusPadding = 10
var textPaddingX = (textboxWidth*0.5) - textBonusPadding
var textPaddingy = (textboxHeight*0.5) - textBonusPadding
var textX = textBoxX - textPaddingX
var textY = textBoxY - textPaddingy
var textWrapLength = textboxWidth-(2*textBonusPadding)
var displayText = ""
for (var i = 0; i<=round(charactersToType); i++;){
	displayText = string_copy(fullLineText, 1, i +string_length(header))
}
draw_text_ext_color(textX, textY, displayText, 10, textWrapLength, c_black, c_black, c_black, c_black, 1)


//Show responses if any
if textIsAllPrinted{
	//Draw indicator of pressing button to continue
}


// Check for if there is more text and we need a page break. Then indicate with a sprite.


// Move to next dialogue step
if textIsAllPrinted && (input("enter")){
	
	show_debug_message(variable_struct_get_names(dialogueBlurb.response_options))
	show_debug_message(dialogueBlurb.response_options)
	if variable_struct_names_count(dialogueBlurb.response_options) != 0{
		var key = variable_struct_get_names(dialogueBlurb.response_options)[0]
		dialogueBlurb = dialogueBlurb.response_options[$ key];
		show_debug_message(typeof(dialogueBlurb))
		textIsAllPrinted = false;
		charactersToType = 0;
	}
}