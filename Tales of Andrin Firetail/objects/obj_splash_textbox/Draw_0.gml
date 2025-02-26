#region Draw the text box 
var cam = camera_get_active()
var textBoxOffsetX = camera_get_view_width(cam)/2//@DIAL
var textBoxOffsetY = camera_get_view_height(cam)/2					//@DIAL
var textboxWidth = camera_get_view_width(cam)/2.5					//@DIAL
//var textboxHeight = camera_get_view_height(cam)/3						//@DIAL
var textBoxX = camera_get_view_x(cam) + textBoxOffsetX
var textBoxY = camera_get_view_y(cam) + textBoxOffsetY
var textBonusPadding = 10
var textWrapLength = textboxWidth-(2*textBonusPadding)
var textboxHeight = string_height_ext(fullLineText, textBonusPadding, textWrapLength) + 3*textBonusPadding
draw_sprite_ext(sprite_index, 0, textBoxX, textBoxY, textboxWidth/sprite_width, textboxHeight/sprite_height, 0, c_white, 1);
#endregion

#region Draw text
var textPaddingX = (textboxWidth*0.5) - textBonusPadding
var textPaddingY = (textboxHeight*0.5) - textBonusPadding
var textX = textBoxX - textPaddingX
var textY = textBoxY - textPaddingY

var displayText = ""
for (var i = 0; i<=round(charactersToType); i++;){
	displayText = string_copy(fullLineText, 1, i)
}
draw_text_ext_color(textX, textY, displayText, textBonusPadding, textWrapLength, c_black, c_black, c_black, c_black, 1)
#endregion

#region "Press Enter"
if textIsAllPrinted{
	var continueIndicatorAnimationSpeed = 0.05
	continueIndicatorAnimationFrame += continueIndicatorAnimationSpeed
	var indicatorSprite = spr_enter_press
	var indicatorColor = c_white
	if gamepad_is_connected(0){
		indicatorSprite = spr_a_press
		indicatorColor = c_green
		}
	
	var indicatorOffsetX = textboxWidth/2 - sprite_get_width(indicatorSprite) + 2
	var indicatorOffsetY = textboxHeight/2 - sprite_get_height(indicatorSprite) + 2
	var indicatorX = textBoxX + indicatorOffsetX
	var indicatorY =  textBoxY + indicatorOffsetY
	var indicatorScaleX = 1
	var indicatorScaleY = 1
	var alpha = 1
	draw_sprite_ext(indicatorSprite, round(continueIndicatorAnimationFrame), indicatorX, indicatorY, indicatorScaleX, indicatorScaleY, 0, indicatorColor, alpha)
}
#endregion