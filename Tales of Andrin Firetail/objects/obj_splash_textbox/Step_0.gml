var charsPerFrame = 2 //@DIAL
charactersToType += charsPerFrame

//Check if text is printed
if charactersToType >= string_length(fullLineText){
	charactersToType = string_length(fullLineText);
	textIsAllPrinted = true;
}

if !textIsAllPrinted && input("enter"){
	charactersToType = string_length(fullLineText)
}

if textIsAllPrinted && input("enter"){
	closeSplashBox = true
}

if closeSplashBox{
	//@TODO Do something here to fade it out or dissolve it or something.
	instance_destroy(self)
}