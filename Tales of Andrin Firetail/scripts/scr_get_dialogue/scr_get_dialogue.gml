function getDialogue(dialogueID){
	try{
		file = file_text_open_read(working_directory + dialogueID + ".txt");
	}
	catch(_exception){
		file = file_text_open_read(program_directory + dialogueID + ".txt");
	}
	var jsonstring = ""
	loop = true
	while loop{
		jsonstring = string_concat(jsonstring, file_text_read_string(file))
		file_text_readln(file);
		if file_text_eof(file){
			loop = false
			file_text_close(file)
		}
	}
	return json_parse(jsonstring)
}