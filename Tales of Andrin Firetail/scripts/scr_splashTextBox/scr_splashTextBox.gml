function splash_text(text, cornerFade = false){
	if cornerFade{
		if instance_number(obj_splash_text_cornerfade) == 0{
			var framesToFloat = string_length(text)*5
			return instance_create_depth(0,0,0, obj_splash_text_cornerfade, {fullLineText: text, framesToFloat: framesToFloat})
		}
	}else{
		if instance_number(obj_splash_text_cornerfade) == 0{
			return instance_create_depth(0,0,0, obj_splash_textbox, {fullLineText: text})
		}
	}
}