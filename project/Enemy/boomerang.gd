extends Enemy


func damage():
	delete()
	
func move(delta: float):
	var parent = get_parent()
	if parent is PathFollow2D:
		parent.set_progress(parent.get_progress() + speed * delta)
