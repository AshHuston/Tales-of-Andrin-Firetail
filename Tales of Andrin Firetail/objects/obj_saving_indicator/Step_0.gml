if framesUntilDelete >= 0{
		if framesUntilDelete == 0 { instance_destroy(self) }
		framesUntilDelete--
}