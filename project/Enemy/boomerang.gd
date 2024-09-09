extends Enemy

var path_index: int = 0
var path: Array[Node]

const delta = 50

func _ready():
	super._ready()
	path = spawn_point.get_boomerang()
	

func damage():
	queue_free()
	
func move(delta: float):
	position = position.move_toward(path[path_index].global_position, speed * delta)
#	var distance = global_position.distance_to(path[path_index].global_position)
#	print(distance)
	if global_position == path[path_index].global_position:
		path_index += 1
