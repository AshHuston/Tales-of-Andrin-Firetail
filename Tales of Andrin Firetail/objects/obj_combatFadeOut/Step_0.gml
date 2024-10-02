// Find best depth
setTopDepth(id)

// Set XY to whatever the camera is
var cameraX = camera_get_view_x(camera_get_active()) 
var cameraY = camera_get_view_y(camera_get_active())
var xOffset = 0
var yOffset = 0

x = cameraX + xOffset
y = cameraY + yOffset

// Make it fade out rather than in
if image_index == 0 {
	instance_destroy(self)	
}
