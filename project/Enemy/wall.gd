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
		delete()

func damage():
	var pos: Vector2
	if active1:
		pos = $enemy_1.global_position
		$enemy_1.queue_free()
		active1 = false
	elif  active2:
		pos = $enemy_2.global_position
		$enemy_2.queue_free()
		active2 = false
	hp -= 1
	$sound.play()
	var exp = explosion_scene.instantiate()
	exp.global_position = pos
	get_parent().add_child(exp)
	if hp == 0:
		delete()
	

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

func touched_soul():
	pass


func delete(remove_from_level: bool = true):
	if remove_from_level:
		level.remove(self)
	queue_free()
