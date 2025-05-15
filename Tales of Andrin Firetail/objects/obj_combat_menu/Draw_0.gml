//Draw the menu background
draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);

//draw the options
draw_set_font(global.font_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

var text = ""


// I am aware that the retroactive addition of the lastUsedAction has been a nightmare.
// I am truly sorry to whoever has to maintain this code later.
var start = 0
if activeCombatant.lastUsedAction.name != "none" && menu_level==0{ start = -1 }
for(var i=start; i<op_length+start; i++)
	{
		if i == -1{ text = option[menu_level, array_length(option[menu_level])-1].name}
		else{text = option[menu_level, i].name;}
		
		var _c = c_white;
		if pos == i {_c = c_black;}
		draw_text_color(x+op_border, y+op_border + (op_space*(i-start)), text, _c, _c, _c, _c, 1);
	}
	
// Description background
if !array_contains(["none", "<--Back", "empty"], combatManagerID.hoveredAction.name){
	var descriptionText = ""
	try{ descriptionText = combatManagerID.hoveredAction.description}catch(err){ descriptionText = "ERROR: ACTION HAS NO LISTED DESCRIPTION" }
	var maxCharWidth = 100 //@DIAL
	var sep = string_height("|") + 2//*op_border //@DIAL
	var descriptionWidth = string_width_ext(descriptionText, sep, maxCharWidth) + (2*op_border)
	var descriptionHeight = string_height_ext(descriptionText, sep, maxCharWidth)+(2*op_border)
	draw_sprite_ext(sprite_index, image_index, descriptionX, descriptionY, descriptionWidth/sprite_width, descriptionHeight/sprite_height, 0, c_white, 1);

	combatManagerID.actionStatsOrigin = [descriptionX, descriptionY+descriptionHeight+seperator]
	
	// Description text
	var textX = descriptionX+op_border
	var textY = descriptionY+op_border
	draw_text_ext_color(textX, textY, descriptionText, sep, maxCharWidth, c_black, c_black, c_black, c_black, 1)
}