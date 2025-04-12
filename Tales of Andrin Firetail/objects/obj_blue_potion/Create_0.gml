itemInfo = {name:"Mana Potion", 
		quantity: 1,
		stackable: true,
		menuPage: "consumables",
		can_use: function canHealUser(targetID){return targetID.secondaryDisplayBarCurrent < targetID.secondaryDisplayBarMax},
		use: function healUser(targetID){
			var refillAmt = 20;
			var canUse = false
			if targetID.secondaryDisplayBar == "MP"{
				if targetID.secondaryDisplayBarCurrent < targetID.secondaryDisplayBarMax{
					targetID.secondaryDisplayBarCurrent += refillAmt
					canUse = true
					if targetID.secondaryDisplayBarCurrent > targetID.secondaryDisplayBarMax{
						refillAmt -= targetID.secondaryDisplayBarCurrent - targetID.secondaryDisplayBarMax
						targetID.secondaryDisplayBarCurrent = targetID.secondaryDisplayBarMax
					}
				}
			}
			return {can_use: canUse, animation_index: "None", restored: refillAmt, logMessage: [{text: "*TARGET", color: c_aqua},{text: "regains", color: c_white},{text: refillAmt, color: c_white},{text: "MP.", color: c_white}]};
		   	}, 
		description:"Restores the user for 20 MP", 
		canTarget:"self",
		actionType:"item",
		combatMenu:true,
		targetID:"",
		bonus_targetID: "",
		animation_index: "None",
		}
		
width = 8
height = 8
xScale = width/sprite_get_width(sprite_index)
yScale = height/sprite_get_height(sprite_index)
scale = xScale
if yScale < scale {scale = yScale}
image_xscale = scale
image_yscale = scale
x += width/2
y += height/2