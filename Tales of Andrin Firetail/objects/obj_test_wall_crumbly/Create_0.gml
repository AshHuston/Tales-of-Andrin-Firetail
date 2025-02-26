event_inherited()

image_alpha = 1
function interact(){
	audio_play_sound(snd_crumblingStone, 1, false)	
	instance_destroy(self)
}