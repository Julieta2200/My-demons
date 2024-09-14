extends Control

@onready var skills_array: Array[Dictionary] = [
	{"texture": $"1/deactive"},
	{"texture": $"2/deactive"},
	{"texture": $"3/deactive"},
]

func deactive_skill(index):
	skills_array[index]["texture"].visible = true

func skill(index):
	skills_array[index]["texture"].visible = false
