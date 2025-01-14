if input("S"){
	url_open("https://docs.google.com/forms/d/e/1FAIpQLSeIDT4ails4exxTRvIx12G7R3mIKZkuFD76v1V-hAZKopuAtg/viewform?usp=header")
}

if input("enter"){
	room_goto(destinationRoom)	
}

alpha += incrimentValue

if alpha > 1 || alpha < 0 { incrimentValue*= -1 }