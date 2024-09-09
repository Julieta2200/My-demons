extends Enemy

@export var step: float
var distance: float

func _ready():
	super._ready()
	distance = soul.global_position.distance_to(global_position)

func damage():
	queue_free()
	
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
	
	global_position = Vector2(x+soul.global_position.x, y+soul.global_position.y)
