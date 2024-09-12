extends Enemy

@export var hp: int = 0

func damage():
	hp += 1
	match hp:
		1:
			$green.visible = false
			$purple.visible = true
		2:
			$purple.visible = false
			$red.visible = true
		3:
			delete()
		
