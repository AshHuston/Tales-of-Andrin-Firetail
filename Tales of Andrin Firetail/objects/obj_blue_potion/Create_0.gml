itemInfo = {name:"Mana Potion", 
		quantity: 1,
		stackable: true,
		menuPage: "consumables",
		use: function healUser(targetID){
			var refillAmt = 20;
			var canUse = false
			if targetID.secondaryDisplayBar == "MP"{
				if targetID.secondaryDisplayBarCurrent < targetID.secondaryDisplayBarMax{
					targetID.secondaryDisplayBarCurrent+= healAmt
					canUse = true
					if targetID.secondaryDisplayBarCurrent > targetID.secondaryDisplaybarMax{
						refillAmt -= targetID.secondaryDisplayBarCurrent - targetID.secondaryDisplayBarMax
						targetID.secondaryDisplayBarCurrent = targetID.secondaryDisplayBarMax
					}
				}
			}
			return {can_use: canUse, animation_index: "None", restored: refillAmt};
		   	}, 
		description:"Restores the user for 20 MP", 
		canTarget:"self",
		actionType:"item",
		combatMenu:true,
		targetID:"",
		bonus_targetID: "",
		animation_index: "None"
		}
		
width = 8
height = 8
xScale = width/sprite_get_width(sprite_index)
yScale = height/sprite_get_height(sprite_index)
scale = xScale
if yScale < scale {scale = yScale}
image_xscale = scale

// @TODO THIS CURRENTLY WILL STILL CONSUME ITSELF FOR NON_MP USERS!!!