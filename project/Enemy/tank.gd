extends Enemy

var hp = 0

func damage():
	hp += 1
	if hp == 3:
		queue_free()
