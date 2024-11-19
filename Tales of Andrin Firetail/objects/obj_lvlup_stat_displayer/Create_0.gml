function getDisplayString(statName){
	var displayString = ""
	//@TODO get this working. Should take "maxHp" and return "HP +3" for example
	return displayString	
}

statsToList = [ //@DIAL
		"maxHp",
		"armor",
		"evasion",
		"magicResist",
		"combatSpeed",
		
//	  \/\/ Weird ones \/\/
		"secondaryDisplayBarMax",
		"secondaryDisplayBarCurrent",
		"edged skill",
		"ranged skill",
		"melee skill",
		"magic skill"
]

name = string_lower(name)
statTable = global.LEVELUP_STAT_TABLES[$ name]

