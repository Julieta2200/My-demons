extends Enemy

@export var step: float
var distance: float
var next_position: Vector2

func _ready():
	super._ready()
	distance = soul.global_position.distance_to(global_position)

func damage():
	delete()
	
func move(delta: float):
	pass

func _on_step_timer_timeout():
	distance -= step
	var x = randf_range(-distance, distance)
	var sign = randf()
	var y: float
	if sign > 0.5:
		y = sqrt(distance*distance - x*x)
	else:
		y = -sqrt(distance*distance - x*x)
	$AnimationPlayer.play("disappear")
	$step_timer.stop()
	next_position = Vector2(x+soul.global_position.x, y+soul.global_position.y)

func disappeared():
	global_position = next_position
	$AnimationPlayer.play("appear")

func appeared():
	$step_timer.start()
