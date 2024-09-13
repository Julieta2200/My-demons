extends Enemy

var target: Vector2


func _ready():
	pass
	
func move(delta: float):
	position = position.move_toward(target, speed * delta)
	if position == target:
		delete()
	

func damage():
	$laser.visible = false
	$laser_visible_timer.start()

func _on_timer_timeout():
	$laser.visible = true

func touched_soul():
	pass
