extends Control

var deactive_sprite = "res://assets/ui/Heart2.png"

@onready var hearts: Array[Dictionary] = [
	{"texture": $"3", "active": true},
	{"texture": $"2", "active": true},
	{"texture": $"1", "active": true},
]

func remove():
	for heart in hearts:
		if !heart["active"]:
			continue
		heart["active"] = false
		heart["texture"].texture = load(deactive_sprite)
		break
		
