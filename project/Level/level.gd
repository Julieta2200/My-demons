extends Node2D

var enemy_scene = preload("res://project/Enemy/cloud.tscn")
var spawn_points: Array
@onready var soul: StaticBody2D = $soul

func _ready():
	spawn_points = $points.get_children()


func _on_enemy_create_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var random_index = randi_range(0, spawn_points.size() - 1)
	var random_point = spawn_points[random_index]
	print(random_point)
#	var path_follow_2d: PathFollow2D = PathFollow2D.new()
	enemy.spawn_point = random_point
	enemy.soul = $soul
	enemy.position = random_point.position
#	random_point.get_boomerang().add_child(path_follow_2d)
#	path_follow_2d.rotates = false
#	path_follow_2d.add_child(enemy)
	$enemies.add_child(enemy)
 
