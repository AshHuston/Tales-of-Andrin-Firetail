function getExpSpeed(current, target){
	var diff = abs(target-current)
	var curveHeight = 1.4	//@DIAL Lower = less deceleration
	var startSpd = 4		//@DIAL Lower = faster
	return power(diff, 1/curveHeight)/startSpd
}


// @TODO MOVING THE CAM WHILE DISPLAYING THIS OBJECT LOOKS WEIRD AND IDK HOW TO FIX IT!
cam = view_get_camera(camera_get_active())
camX = camera_get_view_x(cam)
camY = camera_get_view_y(cam)
camWidth = camera_get_view_width(cam)
camHeight = camera_get_view_height(cam)
windowBottom = camY + camHeight

if y>destY&&framesToFloat>0{y-= getExpSpeed(y, destY)}

if framesToFloat <= 0{
	closeSplashBox = true
}
framesToFloat--
if array_length(global.SPLASH_TEXT_QUEUE){ framesToFloat-- } //This just doubles the speed if theres a queue

if closeSplashBox{
	y+= getExpSpeed(y, destY)
	if y>startY { instance_destroy(self) }
}

