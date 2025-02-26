
if fullLineText == ""{
	fullLineText = "Hello, this is a test to see if this splash screen even works."
}
setTopDepth(id)
alpha = 0

closeSplashBox = false

cam = view_get_camera(camera_get_active())
camX = camera_get_view_x(cam)
camY = camera_get_view_y(cam)
camWidth = camera_get_view_width(cam)
camHeight = camera_get_view_height(cam)
windowBottom = camY + camHeight
cornerPadding = 6 //@DIAL
textboxWidth = camera_get_view_width(cam)/5
textBonusPadding = 10
textWrapLength = textboxWidth-(2*textBonusPadding)
textboxHeight = string_height_ext(fullLineText, textBonusPadding, textWrapLength) + 2*textBonusPadding
 
destY =  -(textboxHeight/2) - cornerPadding
startY = cornerPadding
y = startY