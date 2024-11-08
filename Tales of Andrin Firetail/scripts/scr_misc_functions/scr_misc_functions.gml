function print(str){
	show_debug_message(str)
}

function to_char_array(rawText){
	var characters = []
	for(var i=0; i<string_length(rawText); i++){
		array_push(characters, string_char_at(rawText, i+1))	
	}
	return characters
}

function array_to_ascii_vals(chars){
	var vals = []
	for(var i=0; i<array_length(chars); i++){
		array_push(vals, ord(chars[i]))	
	}
	return vals
}