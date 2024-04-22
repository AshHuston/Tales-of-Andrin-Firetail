depth = -999;

//Textbox paremete3rs
textbox_height = 64;
textbox_width = 200;
border = 8;
line_sep = 12;
line_width = textbox_width - (border*2);
textbox_sprite = spr_menu;
textbox_spd = 0;
sprite_index = textbox_sprite;
//Text
page = 0;
page_number = 0;
text[0] = "";
text_length[0] = string_length(text[0]);
draw_char = 0;
text_spd = 1;
//Options
option[0] = "";
option_link_id[0] = -1;
option_number = 0;
option_pos = 0;

setup = false;

//pause(true);