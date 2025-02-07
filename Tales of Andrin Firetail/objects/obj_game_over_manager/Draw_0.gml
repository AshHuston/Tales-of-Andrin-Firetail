// Background
draw_sprite_ext(spr_gameOverBackground, 0, textTarget[X], textTarget[Y], 400, 400, 0, c_white, backgroundAlpha)

// GAME OVER text
draw_text_transformed_color(textTarget[X], textY, "GAME OVER", 6, 6, 0, c_white, c_white, c_white, c_white, 1)

// Menu Options
if displayOptions{
	for (var i=0; i<menuLength; i++){
		// Dials
		var scale = 3
		var menuX = screenCenter[X] - (0.5*string_width(menuText[i])*scale)
		var menuYSpacing = 6 //@DIAL
		var menuYBuffer = 15
		var menuY = screenCenter[Y] + menuYBuffer + (((string_height(menuText[i])*scale) + menuYSpacing)*i)
		
		// Adjust alpha based on hovered
		var menuAlpha = 0.35
		if pos == i {menuAlpha = 1}
		
		// Actually dispay text
		draw_text_transformed_color(menuX, menuY, menuText[i], scale, scale, 0, c_white, c_white, c_white, c_white, menuAlpha)
	}
}