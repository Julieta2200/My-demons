extends Enemy

@export var hp: int = 0

func damage():
	hp += 1
	if hp == 3:
		delete()
