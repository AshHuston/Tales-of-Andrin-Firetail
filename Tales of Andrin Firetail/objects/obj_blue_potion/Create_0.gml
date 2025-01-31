itemInfo = {name:"Mana Potion", 
		quantity: 1,
		stackable: true,
		menuPage: "consumables",
		use: function healUser(targetID){
			var refillAmt = 20;
			var canUse = false
			if targetID.secondaryDisplaybar == "MP"{
				if targetID.secondaryDisplaybarCurrent < targetID.secondaryDisplaybarMax{
					targetID.secondaryDisplaybarCurrent+= healAmt
					canUse = true
					if targetID.secondaryDisplaybarCurrent > targetID.secondaryDisplaybarMax{
						refillAmt -= targetID.secondaryDisplaybarCurrent - targetID.secondaryDisplaybarMax
						targetID.secondaryDisplaybarCurrent = targetID.secondaryDisplaybarMax
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