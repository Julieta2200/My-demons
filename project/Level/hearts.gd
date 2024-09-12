extends Control

var deactive_sprite = "res://assets/ui/Heart2.png"
var active_sprite = "res://assets/ui/Heart1.png"

@onready var hearts: Array[Dictionary] = [
	{"texture": $"5", "active": false},
	{"texture": $"4", "active": false},
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
		if heart["texture"] == $"1":
			$"../../AnimationPlayer".play("lost")
		break
		
func add_heart():
	for i in range(hearts.size() - 1, -1, -1): 
		var heart = hearts[i]
		if heart["active"]:
			continue 
		heart["active"] = true
		heart["texture"].visible = true
		heart["texture"].texture = load(active_sprite)
		break  

