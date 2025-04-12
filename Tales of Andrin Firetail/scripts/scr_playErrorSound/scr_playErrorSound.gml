function playErrorSound(errId = 0){
	audio_play_sound([snd_error1, snd_error2, snd_error3][errId], 1, false)
	//print("Add an error sound Ash!!!")
}