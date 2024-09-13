

// Will need to come back to this when GB helps me figure it out


function getDialogue(dialogueID){
	show_debug_message(working_directory + dialogueID + ".txt")
	var manualPath = "C:\\Users\\dsguy\\Documents\\GitHub\\Tales-of-Andrin-Firetail\\test assets\\"
	try{
		
		file = file_text_open_read(working_directory + dialogueID + ".txt");
		text = file_text_read_string(file)
	}
	catch(_exception){
		file = file_text_open_read(program_directory + dialogueID + ".txt");
		text = file_text_read_string(file)
	}
	
	
	json = json_decode(text)
	return file
}