class_name Enemy extends CharacterBody2D

@export var speed: float
var soul: StaticBody2D
var targeted: bool 

var level: Level

var spawn_point: Node
var explosion_scene = preload("res://project/Enemy/explosion.tscn")

func _ready():
	var angle = atan2(global_position.y - soul.global_position.y, global_position.x-soul.global_position.x)
	rotate(angle)

func _process(delta):
	move(delta)
	click()

	

func click():
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

func delete(remove_from_level: bool = true):
	if remove_from_level:
		level.remove(self)
	var exp = explosion_scene.instantiate()
	exp.global_position = position
	get_parent().add_child(exp)
	queue_free()

func touched_soul():
	delete()
