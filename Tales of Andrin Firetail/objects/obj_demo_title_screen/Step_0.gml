if input("S"){
	url_open("https://docs.google.com/forms/d/e/1FAIpQLSeMK9dRW7HCzz08Uh2l-wJ5PlLywg76pn8uV-ykzmRv3ADJ8A/viewform?usp=header")
}

if input("enter"){
	room_goto(destinationRoom)	
}

alpha += incrimentValue

if alpha > 1 || alpha < 0 { incrimentValue*= -1 }