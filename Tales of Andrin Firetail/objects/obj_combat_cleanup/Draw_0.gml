#region center cam anchor setup
var camX = camera_get_view_x(cam)
var camY = camera_get_view_y(cam)
var camWidth = camera_get_view_width(cam)
var camHeight = camera_get_view_height(cam)
var anchor = [
	camX + (camWidth/2),
	camY + (camHeight/2)
	]
#endregion

#region Dials
var scalePixels = 30				//@DIAL
var itemSpacing = scalePixels*1.3	//@DIAL
var itemXbuff = 0					//@DIAL
var itemYbuff = camHeight * 2/6		//@DIAL
var barWidth = 80					//@DIAL
var shadeAlpha = 0.65				//@DIAL
var shadeFrames = 12				//@DIAL
var fadeoutFrames = 12				//@DIAL
var blackScreenFrames = 1			//@DIAL  May remove this.
var belowCenter = camY + (camHeight*0.6)
var charPanelXOffset = - (camWidth/8) - (barWidth/2)
var characterAnchors = [
	[camX+charPanelXOffset+(camWidth*2/4), belowCenter],
	[camX+charPanelXOffset+(camWidth*3/4), belowCenter],
	[camX+charPanelXOffset+(camWidth*1/4), belowCenter],
	[camX+charPanelXOffset+(camWidth*4/4), belowCenter],
]
#endregion

#region shade/display stuff
var alpha = shadeAlpha*(shading/shadeFrames)
draw_sprite_ext(spr_solidSquare, 1, anchor[X], anchor[Y], 30, 30, 0, c_black, alpha)
if shading>=shadeFrames{
#region Display loot
isAnimating.lootDisplay = false //@TESTING Currently has no animations.
for (var i=0; i<array_length(loot); i++) {
	if loot[i].quantity > 0 {
		var itemX = anchor[X] + itemXbuff + (itemSpacing*i) 
		var itemY = anchor[Y] + itemYbuff
		var xScale = scalePixels/sprite_get_width(loot[i].sprite)
		var yScale = scalePixels/sprite_get_height(loot[i].sprite)
		var qtyString = "x"+string(loot[i].quantity)
		var qtyCoords = [
			itemX - (scalePixels/2),
			itemY + (scalePixels/2)
		]
		draw_sprite_ext(loot[i].sprite, image_index, itemX, itemY, xScale, yScale, 0, c_white, 1)
		draw_text(qtyCoords[X], qtyCoords[Y], qtyString)
	}
}
#endregion

#region PC exp and models
isAnimating.expBars = false
for (var i=0; i<array_length(characterDisplayVals); i++) { 
	//EXP bar
	var barHeight = sprite_get_height(spr_lifeBarOutline) //@DIAL
	var barXScale = barWidth/sprite_get_width(spr_lifeBarOutline)
	var barYScale = barHeight/sprite_get_height(spr_lifeBarOutline)
	var maxFill = characterDisplayVals[i].expForLevelup
	var barX = characterAnchors[i][X]
	var barY = characterAnchors[i][Y]
	draw_sprite_ext(spr_lifeBarOutline, 0, barX, barY, barXScale, barYScale, 0, c_white, 1)
		
	//Add fill
	var filledWidth = barWidth-2
	var fillPercent = characterDisplayVals[i].startExp/maxFill
	var fillWidth = fillPercent*filledWidth
	var fillXScale = fillWidth/sprite_get_width(spr_lifeBarFiller)
	draw_sprite_ext(spr_lifeBarFiller, 0, barX+1, barY+1, fillXScale, barYScale, 0, c_aqua, 1)
	
	//Draw character sprites
	var sprite = characterDisplayVals[i].characterID.sprite_index
	var spriteHeight = 64
	var spriteXscale = spriteHeight/sprite_get_height(sprite)
	var spriteX = barX + barWidth/2
	var spriteY = barY - string_height("QWERTYUIOPASDFGHJKLZXCVBNM!@#$%^&*()?1234567890/qwertyuiopasdfghjklzxcvbnm") - 5 //@DIAL
	draw_sprite_ext(sprite, image_index, spriteX, spriteY, spriteXscale, spriteXscale, 0, c_white, 1)
	
	//Draw text
	var totAddedExp = characterDisplayVals[i].totalAdded
	var displayExp = string(clamp(round(characterDisplayVals[i].startExp+characterDisplayVals[i].alreadyAdded), 0, totAddedExp))
	var expText = "lvl"+string(characterDisplayVals[i].currentLevel)+ "    +" + displayExp +"exp"
	draw_text_transformed(barX, barY-(string_height(expText))-1, expText, 1, 1, 0)
	
	//Animate filling bar
	var fillSpeedConstants = [	//@DIAL
		0.75, //Added flat
		0.025 //Multipled by the expForTheLevelup
		]
	var fillSpeed = fillSpeedConstants[0] + (characterDisplayVals[i].expForLevelup * fillSpeedConstants[1])
	if characterDisplayVals[i].startExp < characterDisplayVals[i].endExp{ 
		characterDisplayVals[i].startExp += fillSpeed 
		isAnimating.expBars = true;
		}
	
	//Adjust to new level
	if characterDisplayVals[i].startExp >= characterDisplayVals[i].expForLevelup {
		var newLvl = characterDisplayVals[i].currentLevel + 1
		characterDisplayVals[i].characterID.level++ //@TESTING Maybe move this actual levelup.
		characterDisplayVals[i].alreadyAdded += characterDisplayVals[i].startExp
		characterDisplayVals[i].startExp = 0
		characterDisplayVals[i].currentLevel = newLvl	
		characterDisplayVals[i].endExp = characterDisplayVals[i].characterID.totalExp - global.EXP_SCALE[newLvl]
		characterDisplayVals[i].expForLevelup = global.EXP_SCALE[newLvl+1] - global.EXP_SCALE[newLvl]
		instance_create_depth(x, y, 0, obj_lvlup_stat_displayer, {name:characterDisplayVals[i].name, anchor:[spriteX, spriteY]})
	}
}

#endregion
}else{
	shading++	//Shades the background before showing the loot and exp animations
}
#endregion

#region Fadeout 
if fadeout != noone{
	if fadeout.image_index == sprite_get_number(fadeout.sprite_index)-1{
		close_combat()
	}
}
#endregion