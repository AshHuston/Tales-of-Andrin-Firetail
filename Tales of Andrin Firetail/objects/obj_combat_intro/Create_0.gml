stayFrames = 30		//@DIAL
frameCount = 0
setTopDepth(id)
textScale = 10		//@DIAL
displayText = "FIGHT!"
x = anchor[0] + camera_get_view_width(view_get_camera(combatViewport))/2 - (string_width(displayText)*textScale)/2
y = anchor[1] + camera_get_view_height(view_get_camera(combatViewport))/2 - (string_height(displayText)*textScale)/2

