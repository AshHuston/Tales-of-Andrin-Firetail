global.SPLASH_TEXT_QUEUE = []

function splash_text(text, cornerFade = false){
		if cornerFade{
			if instance_number(obj_splash_text_cornerfade) == 0 && instance_number(obj_splash_textbox) == 0{
				var framesToFloat = (string_length(text)*5)
				return instance_create_depth(0,0,0, obj_splash_text_cornerfade, {fullLineText: text, framesToFloat: framesToFloat})
			}else{
				array_push(global.SPLASH_TEXT_QUEUE, {splashText: text, corner: cornerFade})	
			}
		}else{
			return instance_create_depth(0,0,0, obj_splash_textbox, {fullLineText: text})
		}
}

function check_spash_text_queue(){
	if array_length(global.SPLASH_TEXT_QUEUE)>0 && instance_number(obj_splash_text_cornerfade) == 0 && instance_number(obj_splash_textbox) == 0{
		var data = array_shift(global.SPLASH_TEXT_QUEUE)
		splash_text(data.splashText, data.corner)
	}
}