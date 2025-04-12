event_inherited()
//@TESTING For temporary sprite reasons
manualImageScaleX = 16/sprite_width
image_yscale = manualImageScaleX
image_xscale = manualImageScaleX

depth = -6

movementspacesize = 16	//@DIAL
movementSpeed = 3		//@DIAL
facingDir = LEFT
lastFacingDir = LEFT
lastX = 0
lastY = 0
acceptingMovementCommand = true
notAtDestination = false

prevDestinationX = x
prevDestinationY = y

deltaX = 0
deltaY = 0

paused = false

destinationCoords = [x, y]

crystal_inventory = global.CRYSTAL_INVENTORY

name = "Aaron"
//loadGame() //@TESTING
setBaseStats()
combatName = "Aaron"
combatLogColor = c_white//Left intentionally blank
combatBaseSprite = sprite_index
combatDamageSprite = sprite_index

#region @TESTING Items
potion = instance_create_depth(0,0,1000, obj_red_potion).itemInfo
		
elixir = {name:"Elixir", 
		quantity: 5, 
		use: show_debug_message("Elixir used"), 
		description:"Heals user for 30 HP", 
		canTarget:"self",
		actionType:"item",
		combatMenu:true,
		targetID:"",
		bonus_targetID: "",
		animation_index: "None"
		}
		
herb = {name:"Cleansing Herb", 
		quantity: 2, 
		use: function removeNegetiveStatusEffects(targetID){
			var effectsRemoved = [];
			var negetiveEffects = [
			"burned",
			"poison",
			"asleep",
			"hungry",
			"locked-in"
			]
			
			for(var i=0; i<array_length(negetiveEffects); i++;){
				statusEffect = negetiveEffects[i];
				
				var doesMatch = function matches(value, index){
					return (value.name == statusEffect);
					}
					
				// -1 == No matches.
				var foundIndex = array_find_index(targetID.activeEffects, doesMatch);				
				if foundIndex != -1{
					array_push(effectsRemoved, targetID.activeEffects[foundIndex].name);
					var valsToDelete = 1;
					array_delete(targetID.activeEffects, foundIndex, valsToDelete);
				}	
			}
				
				var outputMessage = "Effects removed: ";
				if array_length(effectsRemoved) == 0{
					outputMessage = "No effects were removed.";
				}
				for (var i=0; i<array_length(effectsRemoved); i++;){
					outputMessage = string_concat(outputMessage, effectsRemoved[i], ", ");
				}
				outputMessage = string_trim(outputMessage ,[", "]);
				outputMessage = string_concat(outputMessage, ".");
				return {animation_index: "None", logText: outputMessage};
		}, 
		description:"Removes all negetive status effects.", 
		canTarget:"self",
		actionType:"item",
		combatMenu:true,
		targetID:"",
		bonus_targetID: "",
		animation_index: "None"
		}


#endregion
inventory = global.PLAYER_INVENTORY
//array_push(inventory, potion, herb, elixir, textTest) //@TESTING @TODO Remove these items.

activeEffects = []