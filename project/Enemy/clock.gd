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
	$enemy.visible = false
	$enemy_closed.visible = true
	$laser_visible_timer.start()

func _on_timer_timeout():
	$laser.visible = true
	$enemy.visible = true
	$enemy_closed.visible = false

func touched_soul():
	pass
