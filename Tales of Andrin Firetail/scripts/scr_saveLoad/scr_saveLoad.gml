var rawKey = "AaronLosesHisArm"
global.ENCRYPTION_KEY = array_to_ascii_vals(to_char_array(rawKey))


function encrypt(rawText){
	//Get chars
	var characters = to_char_array(rawText)
	
	//Convert to ASCII values
	var asciiVals = array_to_ascii_vals(characters)
	
	// loop key to be long enough
	var dataLen = array_length(asciiVals)
	var thisKey = array_create(array_length(global.ENCRYPTION_KEY))
	array_copy(thisKey, 0, global.ENCRYPTION_KEY, 0, array_length(global.ENCRYPTION_KEY))
	while true{
		if dataLen > array_length(global.ENCRYPTION_KEY){
			thisKey = array_concat(thisKey, global.ENCRYPTION_KEY)
		}
		else{
			break	
		}
	}
	
	//Do the bitwise crap with the ^ 
	//@TODO Fix the "printable range" issue
		
	var cipherText = ""
	for (var i=0; i<array_length(asciiVals); i++){
		var char = asciiVals[i] ^ thisKey[i]
		cipherText += chr(char)
		//show_debug_message(asciiVals[i])
		//show_debug_message(thisKey[i])
		show_debug_message(char)
		show_debug_message(chr(char))
		//show_debug_message("-----------------------")
	}
	
	return cipherText
}

function decrypt(cipherText){
	
	return rawText
}

function saveGame(){
	
}

function loadGame(){
	
}

//@TESTING
//show_debug_message("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD")//
//show_debug_message(encrypt("hello world"))