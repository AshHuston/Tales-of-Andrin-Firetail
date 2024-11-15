// Set XY to whatever the camera is
var cameraX = camera_get_view_x(camera_get_active()) 
var cameraY = camera_get_view_y(camera_get_active())
var xOffset = 0
var yOffset = 0

x = cameraX + xOffset
y = cameraY + yOffset

if image_number-1 == image_index{
	image_speed = -1
}


if image_index == 0{
	instance_destroy(self)
}