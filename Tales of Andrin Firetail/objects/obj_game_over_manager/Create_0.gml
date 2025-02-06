event_inherited()
maxAlpha = 0.7 //@DIAL
alphaSpeed = 0.025
backgroundAlpha = 0


cam = view_get_camera(combatCam) 
camX = camera_get_view_x(cam)
camY = camera_get_view_y(cam)
camWidth = camera_get_view_width(cam)
camHeight = camera_get_view_height(cam)


X = 0
Y = 1
print(textTarget)
//if textTarget == []{
	textTarget = [
		camX + (camWidth/2)  - (string_width("GAME OVER")*3), 
		camY + (camHeight/2) - (string_height("GAME OVER")*3)
		]
//}
//print(textTarget)
textY = textTarget[Y] - (string_height("GAME OVER")*6.3) - (camHeight/2)
//print(textY)
setTopDepth(id)


/// @TESTING
//textTarget = [
//	global.OVERWORLD_ID_AARON.x- 190,
//	global.OVERWORLD_ID_AARON.y
//]
print(textTarget)