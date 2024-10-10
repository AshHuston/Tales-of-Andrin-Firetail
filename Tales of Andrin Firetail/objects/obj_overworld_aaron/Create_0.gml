event_inherited()
//For temporary sprite reasons
manualImageScaleX = 16/sprite_width
image_yscale = manualImageScaleX
image_xscale = manualImageScaleX

depth = -6

movementspacesize = 16
movementSpeed = 3
facingDir = LEFT
lastFacingDir = LEFT
lastX = 0
lastY = 0
acceptingMovementCommand = true
notAtDestination = false

//x = 168
//y = 168
prevDestinationX = x
prevDestinationY = y

deltaX = 0
deltaY = 0

paused = false

destinationCoords = [x, y]

maxHp = 50;
currentHp = self.maxHp
combatSpeed = 40;
armor = 10;
magicResist = 6;
evasion = 7;
skillRanged = 250;		//@TODO These are just dummy/placeholder stats
skillMelee = 20;		//		to test the Overworld --> Combat object conversion.
skillEdged = 5;
skillMagic = 5;

resistances = []
immunities = []
crystal_inventory = global.CRYSTAL_INVENTORY

name = "Aaron"
secondaryDisplayBar = "MP"
secondaryDisplayBarMax = 0
secondaryDisplayBarCurrent = 0

//@TESTING eq crystals
testCrystal1 = {
	name : "Guard",
	sprite : spr_crystal_1,
	coords: [6,0],
	slave_cells: [],
	other_filled_slots: [], //Left intentionally empty
	effectType: "buff",
	effect: {
		effectSource: "Ephrin's Queen",
		name:"Guard crystal",
		bonusArmor: 15
		}
}
testCrystal2 = {
	name : "Smackdown",
	sprite : spr_crystal_3,
	coords: [6,0],
	slave_cells: [[1,1]],
	other_filled_slots: [], //Left intentionally empty
	effectType: "buff",
	effect: {
		effectSource: "Ephrin's Queen",
		name:"Smackdown crystal",
		skillMelee: 15}
}
testCrystal3 = {
	name : "Speedy",
	sprite : spr_crystal_3,
	coords: [6,0],
	slave_cells: [[1,1]],
	other_filled_slots: [], //Left intentionally empty
	effectType: "buff",
	effect: {
		effectSource: "Ephrin's Queen",
		name:"Speedy crystal",
		combatSpeed: 15
		}
}
array_push(crystal_inventory, testCrystal1, testCrystal2, testCrystal3)

#region @TESTING Items
potion = {name:"Healing Potion", 
		quantity: 5, 
		use: function healUser(targetID){
			var healAmt = round(random_range(15, 30));
			targetID.currentHP += healAmt;
			return {animation_index: "None", hpRestored: healAmt};
		   	}, 
		description:"Heals user for 15-30 HP", 
		canTarget:"self",
		actionType:"item",
		combatMenu:true,
		targetID:"",
		bonus_targetID: "",
		animation_index: "None"
		}
		
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
			
				show_debug_message(outputMessage)
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

textTest = {name:"Text box test", 
		quantity: 5, 
		use: function dumb(){
			instance_create_depth(0, 0, -1000, obj_dialogue_manager, {wholeDialogueStruct: global.DIALGUE_STRUCT})
			return {animation_index: "None", logText: "Testing text"}
		}, 
		description:"Heals user for 30 HP", 
		canTarget:"self",
		actionType:"item",
		combatMenu:true,
		targetID:"",
		bonus_targetID: "",
		animation_index: "None"
		}
#endregion
inventory = [potion, herb, elixir, textTest]

activeEffects = [
{name:"bonus magic resist", bonusMagicResist:12},
{name:"bonusSpeed", value:25}, 
{name:"hungry", state: true}
]