class_name Level extends Node2D

var cloud_scene = preload("res://project/Enemy/cloud.tscn")
var boomerang_scene = preload("res://project/Enemy/boomerang.tscn")
var flash_scene = preload("res://project/Enemy/flash.tscn")
var wall_scene = preload("res://project/Enemy/wall.tscn")
var spawn_points: Array

var wall_left: Marker2D
var wall_right: Marker2D

@onready var soul: StaticBody2D = $soul

func _ready():
	spawn_points = $points.get_children()
	randomize()


func spawn_cloud():
	var enemy = cloud_scene.instantiate()
	var random_index = randi_range(0, spawn_points.size() - 1)
	var random_point = spawn_points[random_index]
	enemy.spawn_point = random_point
	enemy.soul = $soul
	enemy.position = random_point.position
	$enemies.add_child(enemy)
	
func spawn_boomerang():
	var enemy = boomerang_scene.instantiate()
	var random_index = randi_range(0, spawn_points.size() - 1)
	var random_point = spawn_points[random_index]
	var path_follow_2d: PathFollow2D = PathFollow2D.new()
	enemy.spawn_point = random_point
	enemy.soul = $soul
	random_point.get_boomerang().add_child(path_follow_2d)
	path_follow_2d.rotates = false
	path_follow_2d.add_child(enemy)

func spawn_flash():
	var enemy = flash_scene.instantiate()
	var random_index = randi_range(0, spawn_points.size() - 1)
	var random_point = spawn_points[random_index]
	enemy.spawn_point = random_point
	enemy.soul = $soul
	enemy.position = random_point.position
	$enemies.add_child(enemy)

func spawn_wall():
	var enemy = wall_scene.instantiate()
	var rand = randf()
	if rand > 0.5:
		enemy.global_position = wall_right.global_position
		enemy.target = wall_left.global_position
	else:
		enemy.target = wall_right.global_position
		enemy.global_position = wall_left.global_position
	$enemies.add_child(enemy)
