cam = view_get_camera(camera_get_active())
offsetX = 15	//@DIAL
offsetY = 15			//@DIAL
width = camera_get_view_width(cam)				//@DIAL
height = camera_get_view_height(cam)						//@DIAL
x = camera_get_view_x(cam) + width - offsetX
y = camera_get_view_y(cam) + height - offsetY
setTopDepth(id)
framesUntilDelete = -1

function selfDestruct(frames=60){
	framesUntilDelete = frames	
}