global.DIALGUE_STRUCT = {
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
						respondable:true, 
						response_options:
						
							{
								speaker:"Balduk",
								text:"Oh wow, the capital huh? Which district?",
								flag:{
									id:"", 
									value:false
									},
								respondable:false,
								response_options:
							
								{
								north:{
									option_display:"North",
									speaker:"Balduk",
									text:"Love those fields huh!", 
									flag:{
										id:"", 
										value:false}, 
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
									text:"Oh nice, I have a cousin who lives there. Know her?", 
									flag:{
										id:"", 
										value:false
										},
									respondable:false, 
									response_options:{}
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