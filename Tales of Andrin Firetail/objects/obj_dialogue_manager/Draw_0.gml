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
var textBoxOffsetX = 350					//@DIAL
var textBoxOffsetY = 185					//@DIAL
var textboxWidth = 300						//@DIAL
var textboxHeight = 125						//@DIAL
var textBoxX = camera_get_view_x(camera_get_active()) + textBoxOffsetX
var textBoxY = camera_get_view_y(camera_get_active()) + textBoxOffsetY

draw_sprite_ext(sprite_index, 0, textBoxX, textBoxY, textboxWidth/sprite_width, textboxHeight/sprite_height, 0, c_white, 1);
#endregion

#region Draw speaker 
//print(wholeDialogueStruct)
var speakerSprite = getSpeakerSprite()
//print(speakerSprite)
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

//@TODO Find better condition to test for left side
if speakerName == "Aaron"{nameBoxOffsetX = -nameBoxOffsetX}
	
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
var textPaddingX = (textboxWidth*0.5) - textBonusPadding
var textPaddingY = (textboxHeight*0.5) - textBonusPadding
var textX = textBoxX - textPaddingX
var textY = textBoxY - textPaddingY
var textWrapLength = textboxWidth-(2*textBonusPadding)
var displayText = ""
for (var i = 0; i<=round(charactersToType); i++;){
	displayText = string_copy(fullLineText, 1, i)
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
	
	var indicatorOffsetX = 95
	var indicatorOffsetY = 25
	var indicatorX = textBoxX + indicatorOffsetX
	var indicatorY =  textBoxY + indicatorOffsetY
	var indicatorScaleX = 1
	var indicatorScaleY = 1
	alpha = 1
	draw_sprite_ext(indicatorSprite, round(continueIndicatorAnimationFrame), indicatorX, indicatorY, indicatorScaleX, indicatorScaleY, 0, indicatorColor, alpha)
}

