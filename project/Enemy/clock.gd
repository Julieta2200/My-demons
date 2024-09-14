extends Enemy

var target: Vector2


func _ready():
	pass
	
func move(delta: float):
	position = position.move_toward(target, speed * delta)
	if position == target:
		delete()
	

func damage():
	$laser2.stop()
	$laser.visible = false
	$enemy.visible = false
	$laser_area.get_node("CollisionShape2D").disabled = true
	$enemy_closed.visible = true
	$laser_visible_timer.start()

func _on_timer_timeout():
	$laser2.play()
	$laser.visible = true
	$enemy.visible = true
	$laser_area.get_node("CollisionShape2D").disabled = false
	$enemy_closed.visible = false


func touched_soul():
	pass

func slowdown():
	speed = speed / 2
	$laser_visible_timer.wait_time *= 2
	
