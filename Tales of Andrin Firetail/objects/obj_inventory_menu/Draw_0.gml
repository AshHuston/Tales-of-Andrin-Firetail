//Draw the menu background
draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);

//draw the options
draw_set_font(global.font_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

var text = ""


for(var i=0; i<op_length; i++)
	{		
		text = option[menu_level][i].name
		var textX = x+op_border
		var textY = y+op_border + op_space*i
		var _c = c_white;
		#region Display quantity if we can
		if menu_level == 1{ 
			try{text += "  x" + string(option[menu_level][i].quantity);}catch(err){} 
		}
		#endregion
		#region hovered text only
		if pos == i {
			_c = c_black;
			#region Shake for error
			var shakeX = 0
			var shakeY = 0
			if textShakeFrames>0{
				var toneDown = 2
				shakeY = random_range(-textShakeFrames, textShakeFrames)/toneDown
				shakeX = random_range(-textShakeFrames, textShakeFrames)/toneDown
				textX += shakeX
				textY += shakeY
				textShakeFrames --
			}
			#endregion
		}
		#endregion
		
		draw_text_color(textX, textY, text, _c, _c, _c, _c, 1);
	}