extends Enemy

var target: Vector2
var hp = 2

var active1: bool
var active2: bool

func _ready():
	pass

func move(delta: float):
	position = position.move_toward(target, speed * delta)
	if position == target:
		queue_free()

func damage():
	if active1:
		$enemy_1.queue_free()
		active1 = false
	elif  active2:
		$enemy_2.queue_free()
		active2 = false
	hp -= 1
	if hp == 0:
		queue_free()
	

func click():
	if Input.is_action_just_pressed("left") and (active1 or active2):
		damage()

func _on_area_1_mouse_entered():
	active1 = true


func _on_area_2_mouse_entered():
	active2 = true


func _on_area_1_mouse_exited():
	active1 = false

func _on_area_2_mouse_exited():
	active2 = false

func _on_area_2d_area_entered(area):
	pass

func delete():
	pass
