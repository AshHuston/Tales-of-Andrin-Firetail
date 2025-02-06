function getTextSpeed(current, target){
	var diff = abs(target-current)
	var curveHeight = 1.5	//@DIAL Lower = less deceleration
	var startSpd = 7		//@DIAL Lower = faster
	return power(diff, 1/curveHeight)/startSpd
}



if textY < textTarget[Y]{
	textMoveSpeed = getTextSpeed(textY, textTarget[Y])
	textY += textMoveSpeed
}

if backgroundAlpha < maxAlpha{ backgroundAlpha += alphaSpeed }
if backgroundAlpha > maxAlpha{ backgroundAlpha = maxAlpha }