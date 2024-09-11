class_name Level extends Node2D

var cloud_scene = preload("res://project/Enemy/cloud.tscn")
var boomerang_scene = preload("res://project/Enemy/boomerang.tscn")
var flash_scene = preload("res://project/Enemy/flash.tscn")
var wall_scene = preload("res://project/Enemy/wall.tscn")
var luos_sprite_scene = preload("res://project/SpriteFrames/luos_sprite.tscn")
var lilith_sprite_scene = preload("res://project/SpriteFrames/lilith_sprite.tscn")
var damage_light_scene = preload("res://project/Luos/damage_light.tscn")
var clock_scene = preload("res://project/Enemy/clock.tscn")

var spawn_points: Array

var wall_left: Marker2D
var wall_right: Marker2D

var clock_left: Marker2D
var clock_right: Marker2D

var enemies: Dictionary

var first_skill_cooldown: bool
var first_skill_cooldown_timer: Timer

var wave_finished: bool

@onready var soul: StaticBody2D = $soul

func _ready():
	spawn_points = $points.get_children()
	randomize()
	first_skill_cooldown_timer = Timer.new()
	first_skill_cooldown_timer.wait_time = 10
	first_skill_cooldown_timer.one_shot = true
	first_skill_cooldown_timer.connect("timeout", _on_first_skill_cooldown_timer_done)
	add_child(first_skill_cooldown_timer)

func _process(delta):
	if Input.is_action_just_pressed("left"):
		var dl = damage_light_scene.instantiate()
		dl.position = get_viewport().get_mouse_position()
		add_child(dl)
	if Input.is_action_just_pressed("kill_all"):
		delete_enemies()

func spawn_cloud():
	var enemy = cloud_scene.instantiate()
	var random_index = randi_range(0, spawn_points.size() - 1)
	var random_point = spawn_points[random_index]
	enemy.spawn_point = random_point
	enemy.soul = $soul
	enemy.position = random_point.position
	$enemies.add_child(enemy)
	spawn(enemy)
	
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
	spawn(enemy)

func spawn_flash():
	var enemy = flash_scene.instantiate()
	var random_index = randi_range(0, spawn_points.size() - 1)
	var random_point = spawn_points[random_index]
	enemy.spawn_point = random_point
	enemy.soul = $soul
	enemy.position = random_point.position
	$enemies.add_child(enemy)
	spawn(enemy)

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
	spawn(enemy)
	
func spawn_clock():
	var enemy = clock_scene.instantiate()
	var rand = randf()
	if rand > 0.5:
		enemy.global_position = clock_right.global_position
		enemy.target = clock_left.global_position
	else:
		enemy.target = clock_right.global_position
		enemy.global_position = clock_left.global_position
	$enemies.add_child(enemy)
	spawn(enemy)

func spawn(enemy: Enemy):
	enemies[enemy] = true
	enemy.level = self

func remove(enemy: Enemy):
	enemies.erase(enemy)
	if enemies.size() == 0 and wave_finished:
		start_dialog()

func start_dialog():
	pass

func delete_enemies():
	if first_skill_cooldown:
		return
	for enemy in enemies:
		enemy.delete(false)
	enemies = {}
	first_skill_cooldown = true
	first_skill_cooldown_timer.start()
	if enemies.size() == 0 and wave_finished:
		start_dialog()
	
func _on_first_skill_cooldown_timer_done():
	first_skill_cooldown = false

func start_over():
	get_tree().reload_current_scene()

