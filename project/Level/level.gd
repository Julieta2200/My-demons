extends Node2D

var enemy_scene = preload("res://project/Enemy/cloud.tscn")
var spawn_points: Array
@onready var soul: StaticBody2D = $soul

func _ready():
	$soul.position = get_viewport().size / 2
	spawn_points = $points.get_children()


func _on_enemy_create_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var random_index = randi_range(0, spawn_points.size() - 1)
	var random_point = spawn_points[random_index]
	enemy.position = random_point.position
	$enemies.add_child(enemy)
 
