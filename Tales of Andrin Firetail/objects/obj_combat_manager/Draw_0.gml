/// @description Insert description here
// You can write your code in this editor
if hovering >=0 && hovering < array_length(combatants) && step == "Select targets"{
	depth = -100;
	draw_sprite(spr_targetIndicator, -1, combatants[hovering].x, combatants[hovering].y-25);
}