setTopDepth(id)
name = string_lower(name)
statTable = global.LEVELUP_STAT_TABLES[$ name]

function getDisplayString(statName){
	var displayString = ""
	switch (statName){
		case "edged skill":
		case "ranged skill":
		case "melee skill":
		case "magic skill":
			type = string_split(statName, " skill")[0]
			displayString = statName + " +" + string(statTable.combatSkills[$ type])
			break;
		
		case "secondaryDisplayBarMax":
			barName = global.CHARACTER_STATS[$ name].secondaryDisplayBar
			displayString = barName + " +" + string(statTable[$ statName])
			break;
		
		default:
			displayString = statName + " +" + string(statTable[$ statName])
	}
	return displayString	
}

statsToList = [ //@DIAL
		"maxHp",
		"armor",
		"evasion",
		"magicResist",
		"combatSpeed",
		"secondaryDisplayBarMax",	// If 'none' should not display at all.
		"edged skill",
		"ranged skill",	
		"melee skill",
		"magic skill"
]

framesBetweenStats = 7		//@DIAL
raiseSpeed = 1.25 //@DIAL  pixels/frame
xOffsetMax = 0
framesSinceLastStat = 0
displayVars = []
for (var i=0; i<array_length(statsToList); i++;){
	info = {
		text:	getDisplayString(statsToList[i]),
		X:		anchor[0] + random_range(-xOffsetMax, xOffsetMax),
		Y:		anchor[1],
		displayed: false
	}
	if string_pos("none", info.text) == 0{
		array_push(displayVars, info)
	}
}
displayVars[0].displayed = true