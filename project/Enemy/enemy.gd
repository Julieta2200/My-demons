class_name Enemy extends CharacterBody2D

var speed: float = 250
var targeted: bool 
@onready var soul = $"../../soul"

func _process(delta):
	position = position.move_toward(soul.position, speed * delta)
	if Input.is_action_just_pressed("left") and targeted:
		queue_free()
	

func _on_area_2d_mouse_entered():
	targeted = true


func _on_area_2d_mouse_exited():
	targeted = false
