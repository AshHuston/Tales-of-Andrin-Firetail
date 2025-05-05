// Set XY to whatever the camera is
var cameraX = camera_get_view_x(camera_get_active()) 
var cameraY = camera_get_view_y(camera_get_active())
var xOffset = 0
var yOffset = 0

x = cameraX + xOffset
y = cameraY + yOffset

if image_number-1 == image_index{
	instance_destroy(self)	
}

if image_index == 2{ 
	print("stopped ovw music")
	try{ audio_stop_sound(global.OVERWORLD_MUSIC) }catch(err){}
}