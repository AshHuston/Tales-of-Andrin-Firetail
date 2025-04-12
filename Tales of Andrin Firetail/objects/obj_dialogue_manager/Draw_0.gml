function getSpeakerSprite(){
	var speakerName = dialogueBlurb.speaker;
	var allSprites = wholeDialogueStruct.chatSpriteIDs;
	var spriteIndex = ""
	for (var i = 0; i<array_length(allSprites); i++;){
		if allSprites[i].name == speakerName{
			spriteIndex = allSprites[i].spriteID;	
		}
	}
	if spriteIndex == "" { //If the sprite is listed wrong or blank on JSON.
		var defaultSprite = spr_wall
		return asset_get_index(string(defaultSprite))
	}else{
		return asset_get_index(spriteIndex) 
	}
	
}

function getSpeakerSpriteYappingSpeed(){
	var speakerName = dialogueBlurb.speaker;
	var allSprites = wholeDialogueStruct.chatSpriteIDs;
	var yapSpeed = 0
	for (var i = 0; i<array_length(allSprites); i++;){
		if allSprites[i].name == speakerName{
			yapSpeed = allSprites[i].yapping_speed;	
		}
	}
	return yapSpeed;	
}

#region Draw the text box 
var cam = camera_get_active()
var camX = camera_get_view_x(cam)
var camY = camera_get_view_y(cam)
var camHeight = camera_get_view_height(cam)
var camWidth = camera_get_view_width(cam)
var textboxWidth = camWidth*0.7				//@DIAL
var minTextboxHeight = camHeight*0.2			//@DIAL
var maxTextboxHeight = camHeight*0.6			//@DIAL
var textBonusPadding = 10
var lineSpacing = 10
var textWrapLength = textboxWidth-(2*textBonusPadding)
var displayText = string_copy(fullLineText, 1, round(charactersToType))
var numOfLines = 1+floor(string_width(displayText)/textWrapLength)+string_count("\n",displayText)
var lineHeight = lineSpacing//string_height(displayText)//+lineSpacing
var textHeight = lineHeight*numOfLines
var textboxHeight = clamp(textHeight+(textBonusPadding*2), minTextboxHeight, maxTextboxHeight)//@DIAL
var textBoxOffsetX = camWidth/2				//@DIAL
var textBoxOffsetY = camHeight* 3/4			//@DIAL
var textBoxX = camX + textBoxOffsetX
var textBoxY = camY + textBoxOffsetY

draw_sprite_ext(sprite_index, 0, textBoxX, textBoxY, textboxWidth/sprite_width, textboxHeight/sprite_height, 0, c_white, 1);
#endregion

#region Draw speaker 
var speakerSprite = getSpeakerSprite()
var originalHeight = sprite_get_height(speakerSprite)
var originalWidth = sprite_get_width(speakerSprite)
var spriteHightInPixels = 65				//@DIAL
var scaledHeightRatio = spriteHightInPixels/originalHeight
var scaledWidthRatio = scaledHeightRatio * -1 //flip inward. Find a better way to do this.
var scaledWidth = originalWidth*scaledWidthRatio

// Display speaker name
var speakerName = dialogueBlurb.speaker;
var namePlateSprite = sprite_index
var nameBoxPaddingX = 6				//@DIAL
var nameBoxPaddingY = 4				//@DIAL
var nameBoxHeight = (string_height(speakerName) + 2*nameBoxPaddingY)
var nameBoxWidth = (string_width(speakerName) + 2*nameBoxPaddingX)
var minNamePlateWidth = scaledWidth + 2*nameBoxPaddingX
if nameBoxWidth < minNamePlateWidth {nameBoxWidth = minNamePlateWidth}
var nameBoxRightEdgeSpacing = 15				//@DIAL
var nameBoxOffsetX = (textboxWidth/2) - (nameBoxWidth/2) - nameBoxRightEdgeSpacing
if dialogueBlurb.speaker_side == "LEFT"{nameBoxOffsetX = -nameBoxOffsetX}	
var nameBoxOffsetY = -(textboxHeight/2)
var nameBoxX = textBoxX + nameBoxOffsetX
var nameBoxY = textBoxY + nameBoxOffsetY
var alpha = 1
var nameTextOffsetX = -string_width(speakerName)/2
var nameTextOffsetY = -string_height(speakerName)/2
var nameTextX = nameBoxX + nameTextOffsetX
var nameTextY = nameBoxY + nameTextOffsetY

// Display speaker sprite
animationFrame += getSpeakerSpriteYappingSpeed()

if audio_is_playing(voiceover) == false || audio_is_playing(snd_dialogue_silence){
	animationFrame = 0
}

if round(animationFrame) >= sprite_get_number(speakerSprite){
	animationFrame = 0
}

var speakerSpriteOffsetX = 0				//@DIAL
var speakerSpriteOffsetY = -(spriteHightInPixels/2) - 5	//@DIAL
var speakerSpriteX = nameBoxX + speakerSpriteOffsetX
var speakerSpriteY = nameBoxY + speakerSpriteOffsetY

//Draw sprite, then plate, then name.
draw_sprite_ext(speakerSprite, round(animationFrame), speakerSpriteX, speakerSpriteY, scaledWidthRatio, scaledHeightRatio, 0, c_white, 1)
draw_sprite_ext(namePlateSprite, 0, nameBoxX, nameBoxY, nameBoxWidth/sprite_get_width(namePlateSprite), nameBoxHeight/sprite_get_height(namePlateSprite), 0, c_white, alpha)
draw_text_ext_color(nameTextX, nameTextY, speakerName, 0, 1500, c_black, c_black, c_black, c_black, alpha)
#endregion

//--------------------------------------------- Draw text ---------------------
//Write text
var textBonusPadding = 10
var textWrapLength = textboxWidth-(2*textBonusPadding)
var textPaddingX = (textboxWidth*0.5) - textBonusPadding
var textPaddingY = (textboxHeight*0.5) - textBonusPadding
var textX = textBoxX - textPaddingX
var textY = textBoxY - textPaddingY
draw_text_ext_color(textX, textY, displayText, lineSpacing, textWrapLength, c_black, c_black, c_black, c_black, 1)


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
	//show_debug_message(options)
	
	for (var i = 0; i<5; i++;){
		var response
		switch (i+1){
			case 1: 
				response = "response_1"; break;
			case 2: 
				response = "response_2"; break;
			case 3: 
				response = "response_3"; break;
			case 4: 
				response = "response_4"; break;
			case 5: 
				response = "response_5"; break;
		}
		try{
			var responseData = variable_struct_get(dialogueBlurb.response_options, response)
			var responseText = responseData.display_text
			var textWidth = string_width(responseText)
			var boxWidth = (textWidth + (boxPadding*2))/sprite_width
			var boxX = textBoxX - (0.5*textboxWidth/sprite_width) + boxOffsetX  + (textWidth/2)
			var boxY =  textBoxY - (0.5*textboxHeight/sprite_height) - ((boxHeight*2 + optionSpacing)*i) + boxOffsetY
			var responseX = boxX - (boxWidth*0.5*sprite_width) + textOffsetX
			var responseY = boxY + textOffsetY
			alpha = 1
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
		catch(test){
			//show_debug_message(response)	
		}
	}
}


// Check for if there is more text and we need a page break. Then indicate with a sprite.


if textIsAllPrinted{
	//&& !optionsAreDisplayed{
	var continueIndicatorAnimationSpeed = 0.05
	continueIndicatorAnimationFrame += continueIndicatorAnimationSpeed
	//Draw indicator of pressing button to continue
	//Select sprite
	var indicatorSprite = spr_enter_press
	var indicatorColor = c_white
	if gamepad_is_connected(0){
		indicatorSprite = spr_a_press
		indicatorColor = c_green
		}
	var cornerSpacing = 3 //@DIAL
	var indicatorOffsetX = textboxWidth/2 - sprite_get_width(indicatorSprite) + cornerSpacing
	var indicatorOffsetY = textboxHeight/2 - sprite_get_height(indicatorSprite) + cornerSpacing
	var indicatorX = textBoxX + indicatorOffsetX
	var indicatorY =  textBoxY + indicatorOffsetY
	var indicatorScaleX = 1
	var indicatorScaleY = 1
	var alpha = 1
	draw_sprite_ext(indicatorSprite, round(continueIndicatorAnimationFrame), indicatorX, indicatorY, indicatorScaleX, indicatorScaleY, 0, indicatorColor, alpha)
}

