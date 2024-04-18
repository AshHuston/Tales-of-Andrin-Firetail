HP = 50;
combatSpeed = 40;
armor = 12;
magicResist = 6;
skillRanged = 25;		//@TODO These are just dummy/placeholder stats
skillMelee = 20;		//		to test the Overworld --> Combat object conversion.
skillEdged = 5;
skillMagic = 5;

potion = {name:"Healing Potion", 
		quantity: 5, 
		use: function healUser(targetID){
			var healAmt = round(random_range(15, 30));
			targetID.currentHP += healAmt;
			return healAmt;
		   	}, 
		description:"Heals user for 15-30 HP", 
		canTarget:"self"
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
					return value.name == statusEffect;
					}
				
				// -1 == No matches.
				var foundIndex = array_find_index(targetID.activeEffects, doesMatch);				
				if foundIndex != -1{
					array_push(effectsRemoved, targetID.activeEffects[foundIndex]);
					
					var valsToDelete = 1;
					array_delete(targetID.activeEffects, foundIndex, valsToDelete);
				}
			}
			
			return effectsRemoved;
		   	}, 
		description:"Removes all negetive status effects.", 
		canTarget:"self"
		}


inventory = [potion, herb]

activeEffects = [
{bonusMagicResist:-12},{bonusSpeed:25}
]