extends Enemy

@onready var sp_container: Node2D = $split_points
var spawn_points: Array
var small_cloud = preload("res://project/Enemy/small_cloud.tscn")

func _ready():
	super._ready()
	spawn_points = sp_container.get_children()
	
	

func damage():
	split()
	
func split():
	for sp in spawn_points:
		var sc = small_cloud.instantiate()
		sc.global_position = sp.global_position
		get_parent().add_child(sc)
	queue_free()
