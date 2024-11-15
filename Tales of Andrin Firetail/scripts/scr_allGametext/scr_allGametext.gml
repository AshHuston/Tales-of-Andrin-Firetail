//global.DIALGUE_STRUCT = json_decode("{\"dialogueID\": \"0\", \"chatSpriteIDs\": [{\"name\": \"Balduk\", \"spriteID\": \"\", \"yapping_speed\": 0.5}, {\"name\": \"Aaron\", \"spriteID\": \"\", \"yapping_speed\": 0.5}], \"dialogue\": {\"voiceover_id\": \"0_1\", \"display_text\": \"\", \"speaker\": \"Balduk\", \"speaker_side\": \"RIGHT\", \"text\": \"Hi, this is some example dialogue. Isn't that neat! Anyways, you don't look like you're from around here. Where are you from?\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": true, \"response_1\": {\"voiceover_id\": \"0_2\", \"display_text\": \"Irkenstead\", \"speaker\": \"Aaron\", \"speaker_side\": \"LEFT\", \"text\": \"Oh, I'm from the capital! Irkenstead.\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": false, \"response_1\": {\"voiceover_id\": \"0_4\", \"display_text\": \"\", \"speaker\": \"Balduk\", \"speaker_side\": \"RIGHT\", \"text\": \"Oh wow, the capital huh? Which district?\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": true, \"response_1\": {\"voiceover_id\": \"0_5\", \"display_text\": \"North\", \"speaker\": \"Balduk\", \"speaker_side\": \"RIGHT\", \"text\": \"Love those fields huh!\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": false, \"response_1\": NaN, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_2\": {\"voiceover_id\": \"0_6\", \"display_text\": \"West\", \"speaker\": \"Balduk\", \"speaker_side\": \"RIGHT\", \"text\": \"Nice river right?\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": false, \"response_1\": NaN, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_3\": {\"voiceover_id\": \"0_7\", \"display_text\": \"South\", \"speaker\": \"Balduk\", \"speaker_side\": \"RIGHT\", \"text\": \"Trade district huh, lots of hustle and bustle I guess.\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": false, \"response_1\": NaN, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_4\": {\"voiceover_id\": \"0_8\", \"display_text\": \"East\", \"speaker\": \"Balduk\", \"speaker_side\": \"RIGHT\", \"text\": \"Oh nice, I have a cousin who lives there.\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": false, \"response_1\": NaN, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_5\": NaN}, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_2\": {\"voiceover_id\": \"0_3\", \"display_text\": \"The College of Irkenstead!\", \"speaker\": \"Aaron\", \"speaker_side\": \"LEFT\", \"text\": \"I am enrolled at ~The College of Irkenstead~!\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": false, \"response_1\": {\"voiceover_id\": \"0_9\", \"display_text\": \"\", \"speaker\": \"Balduk\", \"speaker_side\": \"RIGHT\", \"text\": \"Oh...I see...\", \"flag_id\": \"refuseToSellPotions\", \"flag_value\": true, \"respondable\": false, \"response_1\": NaN, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_3\": {\"voiceover_id\": \"none\", \"display_text\": \"...\", \"speaker\": \"Aaron\", \"speaker_side\": \"LEFT\", \"text\": \"...*silence*...\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": false, \"response_1\": {\"voiceover_id\": \"0_10\", \"display_text\": \"\", \"speaker\": \"Balduk\", \"speaker_side\": \"RIGHT\", \"text\": \"Alright then, keep your secrets.\", \"flag_id\": \"\", \"flag_value\": false, \"respondable\": false, \"response_1\": NaN, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_2\": NaN, \"response_3\": NaN, \"response_4\": NaN, \"response_5\": NaN}, \"response_4\": NaN, \"response_5\": NaN}}")

var file = file_text_open_read("testDialogue.txt")
var loop = true
var jsonstring = ""
while loop{
	jsonstring = string_concat(jsonstring, file_text_read_string(file))
	file_text_readln(file);
	if file_text_eof(file){
		loop = false
	}
}

file_text_close(file)

global.DIALGUE_STRUCT = json_parse(jsonstring)


print(global.DIALGUE_STRUCT)
/*
global.DIALGUE_STRUCT = {
	chatSpriteIDs:[
	{
	name:"Aaron", 
	spriteID: spr_aaron_dialogue,
	yappingSpeed : 0.6
	}, 
	{name:"Big Boss man MARIO MARIO",
	spriteID: spr_mario,
	yappingSpeed : 0.3
	},
	{name:"Mario",
	spriteID: spr_mario,
	yappingSpeed : 0.3
	}
	],
	dialgueID: 0,
	dialogue:{
			speaker:"Mario", 
			text:"Hi, this is some example dialogue. Isn't that neat! Anyways, you don't look like you're from around here. Where are you from?", 
			voiceoverID: "0_1",
			flag:{
				id:"", 
				value:false
				}, 
			respondable:true,
			response_options:
				{
				response_1:
					{
						option_display:"Irkenstead",
						speaker:"Aaron", 
						text:"Oh, I'm from the capital! Irkenstead.", 
						voiceoverID: "0_2",
						flag:{
							id:"", 
							value:false
							}, 
						respondable:false, 
						response_options:
						{
							response_1:
							{
								speaker:"Big Boss man MARIO MARIO",
								text:"Oh wow, the capital huh? Which district?",
								voiceoverID: "0_4",
								flag:{
									id:"", 
									value:false
									},
								respondable:true,
								response_options:
								{
									response_1:{
										option_display:"North",
										speaker:"Big Boss man MARIO MARIO",
										text:"Love those fields huh!", 
										voiceoverID: "0_5",
										flag:{
											id:"", 
											value:false
											}, 
										respondable:false, 
										response_options:{}
										}, 
									response_2:{
										option_display:"West",
										speaker:"Big Boss man MARIO MARIO", 
										text:"Nice river right?", 
										voiceoverID: "0_6",
										flag:{
											id:"", 
											value:false
											}, 
										respondable:false, 
										response_options:{}
										}, 
									response_3:{
										option_display:"South",
										speaker:"Big Boss man MARIO MARIO", 
										text:"Trade district huh, lots of hustle and bustle I guess.", 
										voiceoverID: "0_7",
										flag:{
											id:"",
											value:false
											}, 
											respondable:false, 
											response_options:{}
											},
									response_4:{
										option_display:"East",
										speaker:"Big Boss man MARIO MARIO", 
										text:"Oh nice, I have a cousin who lives there.", 
										voiceoverID: "0_8",
										flag:{
											id:"", 
											value:false
											},
										respondable:false, 
										response_options:{}
									}
								}
							}
						}
					},

				response_2:
					{
						option_display:"The College of Irkenstead!",
						speaker:"Aaron", 
						text:"I am enrolled at ~The College of Irkenstead~!", 
						voiceoverID: "0_3",
						flag:{
							id:"", 
							value:false
							}, 
						respondable:false, 
						response_options:
						{
							response_1:{
								option_display:"",
								speaker:"Big Boss man MARIO MARIO", 
								text:"Oh...I see...",
								voiceoverID: "0_9",
								flag:{
									id:"refuseToSellPotions", 
									value:true
								}, 
								respondable:false, 
								response_options:{}
							}
						}
					},

				response_3:
					{
						option_display:"Say nothing.",
						speaker:"Aaron", 
						text:"...*silence*...",
						voiceoverID: "",
						flag:{
							id:"", 
							value:false
						}, 
						respondable:false, 
						response_options:
						{
							response_1:{
								speaker:"Big Boss man MARIO MARIO",
								text:"Alright then, keep your secrets.",
								voiceoverID: "0_10",
								flag:{
									id:"", 
									value:false
									},
								respondable:false, 
								response_options:{}	
							}
						}
					}
				}
			}
		}
		

/*
{
	chatSpriteIDs:[
	{
	name:"Aaron", 
	spriteID: spr_smiley
	}, 
	{name:"Balduk",
	spriteID: spr_testRoy
	}
	],
	dialgueID: 0,
	dialogue:{
			speaker:"Balduk", 
			text:"Hi, this is some example dialogue. Isn't that neat! Anyways, you don't look like you're from around here. Where are you from?", 
			flag:{
				id:"", 
				value:false
				}, 
			respondable:true,
			response_options:
				{
				Irkenstead:
					{
						option_display:"Irkenstead",
						speaker:"Aaron", 
						text:"Oh, I'm from the capital! Irkenstead.", 
						flag:{
							id:"", 
							value:false
							}, 
						respondable:false, 
						response_options:
						{
							whichDistrict:
							{
								speaker:"Balduk",
								text:"Oh wow, the capital huh? Which district?",
								flag:{
									id:"", 
									value:false
									},
								respondable:true,
								response_options:
								{
								north:{
									option_display:"North",
									speaker:"Balduk",
									text:"Love those fields huh!", 
									flag:{
										id:"", 
										value:false
										}, 
									respondable:false, 
									response_options:{}
									}, 
								west:{
									option_display:"West",
									speaker:"Balduk", 
									text:"Nice river right?", 
									flag:{
										id:"", 
										value:false
										}, 
									respondable:false, 
									response_options:{}
									}, 
								south:{
									option_display:"South",
									speaker:"Balduk", 
									text:"Trade district huh, lots of hustle and bustle I guess.", 
									flag:{
										id:"",
										value:false
										}, 
										respondable:false, 
										response_options:{}
										},
								east:{
									option_display:"East",
									speaker:"Balduk", 
									text:"Oh nice, I have a cousin who lives there.", 
									flag:{
										id:"", 
										value:false
										},
									respondable:false, 
									response_options:{}
									}
								}
							}
						}
					},

				college:
					{
						option_display:"The College of Irkenstead!",
						speaker:"Aaron", 
						text:"I am enrolled at ~The College of Irkenstead~!", 
						flag:{
							id:"", 
							value:false
							}, 
						respondable:false, 
						response_options:
						{
							ohOkay:{
								option_display:"",
								speaker:"Balduk", 
								text:"Oh...I see...", 
								flag:{
									id:"refuseToSellPotions", 
									value:true
								}, 
								respondable:false, 
								response_options:{}
							}
						}
					},

				silence:
					{
						option_display:"...",
						speaker:"Aaron", 
						text:"...*silence*...", 
						flag:{
							id:"", 
							value:false
						}, 
						respondable:false, 
						response_options:
						{
							okayFine:{
								speaker:"Balduk",
								text:"Alright then, keep your secrets.",
								flag:{
									id:"", 
									value:false
									},
								respondable:false, 
								response_options:{}	
							}
						}
					}
				}
			}
		}
		*/