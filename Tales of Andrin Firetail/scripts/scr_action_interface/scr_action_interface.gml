function checkActionForVariables(details){
	var defaultVals = {
		crit_chance_percent : 5,
		crit_dmg_mod : 1.5,
		targetID: "",
		bonus_targetID: "",
		dmg_type: "normal",
		min_dmg: 0,
		max_dmg: 1,
		hit_chance: 100,
		effect_chance: 0,
		effect_type: "none",
	}
	//if !variable_struct_exists(details, "crit_chance_percent"){details.crit_chance_percent = defaultVals.crit_chance_percent}
	//if !variable_struct_exists(details, "crit_dmg_mod"){details.crit_dmg_mod = defaultVals.crit_dmg_mod}
	var keys = struct_get_names(defaultVals)
	for (var i=0; i<array_length(keys); i++){
		if !variable_struct_exists(details, keys[i]){
			variable_struct_set(details, keys[i], variable_struct_get(defaultVals, keys[i]))
		}
	}
}