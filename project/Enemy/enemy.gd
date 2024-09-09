class_name Enemy extends CharacterBody2D

@export var speed: float
var soul: StaticBody2D
var targeted: bool 

var spawn_point: Node

func _ready():
	var angle = atan2(global_position.y - soul.global_position.y, global_position.x-soul.global_position.x)
	rotate(angle)

func _process(delta):
	move(delta)
	if Input.is_action_just_pressed("left") and targeted:
		damage()
	

func move(delta: float):
	position = position.move_toward(soul.position, speed * delta)

func _on_area_2d_mouse_entered():
	targeted = true


func _on_area_2d_mouse_exited():
	targeted = false

func damage():
	pass
