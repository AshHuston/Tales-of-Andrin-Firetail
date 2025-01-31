if !instance_exists(pairedObjId){
	combatManagerId.waitingForEvent = false
	combatManagerId.waitFrames = 5
	instance_destroy(self)
}