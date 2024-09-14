extends Control

var active_sprite = load("res://assets/ui/un-removebg-preview.png")
var deactive_sprite = load("res://assets/ui/p-removebg-preview.png")

@onready var skills_array: Array[Dictionary] = [
	{"texture": $"1/TextureRect", "active": false},
	{"texture": $"2/TextureRect", "active": false},
	{"texture": $"3/TextureRect", "active": false},
]

func deactive_skill(index):
	skills_array[index]["texture"].texture = deactive_sprite

func skill(index):
	skills_array[index]["active"] = true
	if !skills_array[index]["active"]:
		skills_array[index]["texture"].texture = deactive_sprite
		skills_array[index]["active"] = false
	else:
		skills_array[index]["texture"].texture = active_sprite
		skills_array[index]["active"] = true
