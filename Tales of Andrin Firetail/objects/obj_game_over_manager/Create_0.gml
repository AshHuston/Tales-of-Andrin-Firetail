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
screenCenter = [
	camX + (camWidth/2), 
	camY + (camHeight/2)
]
textTarget = [
	screenCenter[X]  - (string_width("GAME OVER")*3), 
	screenCenter[Y] - (string_height("GAME OVER")*3)
	]
textY = textTarget[Y] - (string_height("GAME OVER")*6.3) - (camHeight/2)
setTopDepth(id)

displayOptions = false
pos = 0
btn_pressed = false
menuText = [
		"Load last save",
		"Exit to menu",
	]
menuLength = array_length(menuText)