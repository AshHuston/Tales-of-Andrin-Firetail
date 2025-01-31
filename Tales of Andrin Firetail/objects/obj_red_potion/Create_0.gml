itemInfo = {name:"Healing Potion", 
		quantity: 1,
		stackable: true,
		use: function healUser(targetID){
			var healAmt = 30;
			var startHp = targetID.currentHp
			targetID.currentHp += healAmt;
			if targetID.currentHp > targetID.maxHp{targetID.currentHp = targetID.maxHp}
			healAmt = targetID.currentHp - startHp
			return {animation_index: "None", hpRestored: healAmt, can_use:(startHp < targetID.maxHp)};
		   	}, 
		description:"Heals user for 30 HP", 
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
image_yscale = scale