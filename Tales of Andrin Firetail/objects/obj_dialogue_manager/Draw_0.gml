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

//----------------------------------------- Draw the text box ---------------------------------
var textBoxX = camera_get_view_x(camera_get_active()) + 350
var textBoxY = camera_get_view_y(camera_get_active()) + 185
var textboxWidth = 300
var textboxHeight = 125
draw_sprite_ext(sprite_index, 0, textBoxX, textBoxY, textboxWidth/sprite_width, textboxHeight/sprite_height, 0, c_white, 1);


//------------------------------------------ Display speaker ---------------------
// Display speaker name
show_debug_message(dialogueBlurb)
var speaker = dialogueBlurb.speaker;
var header = string_concat(speaker, "\n", "------", "\n")
fullLineText = string_concat(header, fullLineText)

// Display speaker sprite
var speakerSprite = getSpeakerSprite()


//--------------------------------------------- Draw text ---------------------
//Write text
var textBonusPadding = 10
var textPaddingX = (textboxWidth*0.5) - textBonusPadding
var textPaddingY = (textboxHeight*0.5) - textBonusPadding
var textX = textBoxX - textPaddingX
var textY = textBoxY - textPaddingY
var textWrapLength = textboxWidth-(2*textBonusPadding)
var displayText = ""
for (var i = 0; i<=round(charactersToType); i++;){
	displayText = string_copy(fullLineText, 1, i +string_length(header))
}
draw_text_ext_color(textX, textY, displayText, 10, textWrapLength, c_black, c_black, c_black, c_black, 1)


//------------------------------------------- Show responses if any ------------------
if (dialogueBlurb.respondable && textIsAllPrinted){
	optionsAreDisplayed = true
	var optionSprite = spr_menu_1
	var boxPadding = 3
	var boxHeight = (10+(boxPadding)*2)/sprite_height
	var optionSpacing = 14 + boxPadding
	var boxOffsetX = -144
	var boxOffsetY = -75
	var textOffsetX = boxPadding + 1
	var textOffsetY = -4
	
	
	//var options = variable_struct_get_names(dialogueBlurb.response_options)
	
	for (var i = 0; i<array_length(options); i++;){
		var responseData = variable_struct_get(dialogueBlurb.response_options, options[i])
	
		var responseText = responseData.option_display
		var textWidth = string_width(responseText)
		var boxWidth = (textWidth + (boxPadding*2))/sprite_width
		var boxX = textBoxX - (0.5*textboxWidth/sprite_width) + boxOffsetX  + (textWidth/2)
		var boxY =  textBoxY - (0.5*textboxHeight/sprite_height) - ((boxHeight*2 + optionSpacing)*i) + boxOffsetY
		var responseX = boxX - (boxWidth*0.5*sprite_width) + textOffsetX
		var responseY = boxY + textOffsetY
		var alpha = 1
		if responseData == hoveredOption{
			draw_sprite_ext(optionSprite, image_index, boxX, boxY, boxWidth, boxHeight, 0, c_white, alpha)
			draw_text_ext_color(responseX, responseY, responseText, 2, 1500, c_black, c_black, c_black, c_black, alpha)
		}
		else{
			alpha = 0.5
			draw_sprite_ext(optionSprite, image_index, boxX, boxY, boxWidth, boxHeight, 0, c_white, alpha)		
			draw_text_ext_color(responseX, responseY, responseText, 2, 1500, c_black, c_black, c_black, c_black, alpha)		
		}	
	}
}


// Check for if there is more text and we need a page break. Then indicate with a sprite.


if textIsAllPrinted && !optionsAreDisplayed{
	
	//Draw indicator of pressing button to continue
}

