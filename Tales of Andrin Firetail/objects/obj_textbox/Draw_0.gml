textbox_x = camera_get_view_x(view_camera[0]) + 10;
textbox_y = camera_get_view_y(view_camera[0]) + 144;
sprite_index = textbox_sprite;
//Setup
if setup == false 
	{
		setup = true;
		draw_set_font(global.font_main);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		
		//loop through the page numbers
		for (var p = 0; p < page_number; p++)
		{
				text_length[p] = string_length(text[p]);
		}
	}

//Type the text
if draw_char < text_length[page]
 {
	draw_char += text_spd;
	draw_char = clamp(draw_char, 0, text_length[page]);
 }
 
 //flip through pages
 if input("enter")
 {
	//if typing done
	if draw_char == text_length[page]
	{
		//Next page
		if page < page_number - 1
		{
			page++;
			draw_char = 0;
		} 
		else 
		{
			if option_number > 0
			{
				create_textbox(option_link_id[option_pos]);	
			}
			instance_destroy(self);
		}
	}
	//If not done typing
	else 
	{
		draw_char = text_length[page];	
	}
 }
 
 
 //Draw textbox
 draw_sprite_ext(textbox_sprite, 0, textbox_x, textbox_y, textbox_width/sprite_width, textbox_height/sprite_height, 0, c_white, 1);
 
 //Options
 if draw_char == text_length[page] && page == page_number - 1
 {
	 //Selector
	option_pos += input("down") - input("up");
	//option_pos = clamp(option_pos, 0, option_number-1);
	if option_pos == -1 {option_pos = option_number -1}
	if option_pos == option_number {option_pos = 0}
	
	var opacity = 0.5;
	 //Draw options
	var op_space = 16;
	var op_bord = 4;
	var y_offset = 3;
	for (var op = 0; op < option_number; op++)
	{
		if option_pos == op{opacity = 1;}else{opacity = 0.5;}
		var _op_w = string_width(option[op]) + (op_bord*2);
		draw_sprite_ext(textbox_sprite, 0, textbox_x, textbox_y - op_space*option_number + op_space*op, clamp(_op_w, 25, 10000)/sprite_width, (op_space - 1)/sprite_height, 0, c_white, opacity )	
		draw_text(textbox_x + op_bord, (textbox_y - op_space*option_number + op_space*op) + y_offset, option[op]);
	}
 }
 
 //Draw text
 var drawtext = string_copy(text[page], 1, draw_char);
 draw_text_ext(textbox_x + border, textbox_y + border, drawtext, line_sep, line_width);