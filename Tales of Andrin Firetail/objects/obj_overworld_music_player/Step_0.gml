if !audio_is_playing(musicId) 
&& !global.ALL_GAME_FLAGS.general.isInCombat 
&& global.ALL_GAME_FLAGS.demo.playDungeonMusic
{
	print("MUSIC START")
	global.OVERWORLD_MUSIC = audio_play_sound(musicId, 2, true, 0.7)
}