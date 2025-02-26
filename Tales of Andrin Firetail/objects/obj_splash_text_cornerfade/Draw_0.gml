#region Draw the text box 
var textBoxY = windowBottom + y
var textBoxX = camX + cornerPadding + (textboxWidth/2)
draw_sprite_ext(sprite_index, 0, textBoxX, textBoxY, textboxWidth/sprite_width, textboxHeight/sprite_height, 0, c_white, 1);
#endregion

#region Draw text
var textPaddingX = (textboxWidth*0.5) - textBonusPadding
var textPaddingY = (textboxHeight*0.5) - textBonusPadding
var textX = textBoxX - textPaddingX
var textY = textBoxY - textPaddingY

draw_text_ext_color(textX, textY, fullLineText, textBonusPadding, textWrapLength, c_black, c_black, c_black, c_black, 1)
#endregion
