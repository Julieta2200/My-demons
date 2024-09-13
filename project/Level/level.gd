class_name Level extends Node2D

var cloud_scene = preload("res://project/Enemy/cloud.tscn")
var boomerang_scene = preload("res://project/Enemy/boomerang.tscn")
var flash_scene = preload("res://project/Enemy/flash.tscn")
var wall_scene = preload("res://project/Enemy/wall.tscn")
var tank_scene = preload("res://project/Enemy/tank.tscn")

var luos_sprite_scene = preload("res://project/SpriteFrames/luos_sprite.tscn")
var lilith_sprite_scene = preload("res://project/SpriteFrames/lilith_sprite.tscn")
var gary_sprite_scene = preload("res://project/SpriteFrames/gary_sprite.tscn")
var ina_sprite_scene = preload("res://project/SpriteFrames/ina_sprite.tscn")
var shiny_sprite_scene = preload("res://project/SpriteFrames/shiny_sprite.tscn")
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

var second_skill_cooldown: bool
var second_skill_cooldown_timer: Timer

var third_skill_cooldown: bool
var third_skill_cooldown_timer: Timer
var wave_finished: bool

@onready var soul: StaticBody2D = $soul
@onready var hearts = $CanvasLayer/hearts

func _ready():
	spawn_points = $points.get_children()
	randomize()
	#first_skill
	first_skill_cooldown_timer = Timer.new()
	first_skill_cooldown_timer.wait_time = 10
	first_skill_cooldown_timer.one_shot = true
	first_skill_cooldown_timer.connect("timeout", _on_first_skill_cooldown_timer_done)
	add_child(first_skill_cooldown_timer)
	#first_skill
	
	#second_skill
	second_skill_cooldown_timer = Timer.new()
	second_skill_cooldown_timer.wait_time = 10
	second_skill_cooldown_timer.one_shot = true
	second_skill_cooldown_timer.connect("timeout", _on_second_skill_cooldown_timer_done)
	add_child(second_skill_cooldown_timer)
	second_skill_cooldown_timer.start()
	#second_skill
	
	#third_skill
	third_skill_cooldown_timer = Timer.new()
	third_skill_cooldown_timer.wait_time = 10
	third_skill_cooldown_timer.one_shot = true
	third_skill_cooldown_timer.connect("timeout", _on_third_skill_cooldown_timer_done)
	add_child(third_skill_cooldown_timer)
	#third_skill

func _process(delta):
	if Input.is_action_just_pressed("left"):
		var dl = damage_light_scene.instantiate()
		dl.position = get_viewport().get_mouse_position()
		add_child(dl)
	if Input.is_action_just_pressed("kill_all"):
		delete_enemies()
	if Input.is_action_just_pressed("heal") and second_skill_cooldown:
		heal()
	if Input.is_action_just_pressed("enemy_slowdown"):
		enemy_slowdown()

func spawn_cloud():
	var enemy = cloud_scene.instantiate()
	var random_index = randi_range(0, spawn_points.size() - 1)
	var random_point = spawn_points[random_index]
	enemy.spawn_point = random_point
	enemy.soul = $soul
	enemy.position = random_point.position
	$enemies.add_child(enemy)
	spawn(enemy)

func spawn_tank():
	var enemy = tank_scene.instantiate()
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
	first_skill_cooldown = true

func start_over():
	get_tree().reload_current_scene()
	
	
func _on_second_skill_cooldown_timer_done():
	second_skill_cooldown = true
	print("after 10 sec")
	

func heal():
	second_skill_cooldown = false
	hearts.add_heart()

func _on_third_skill_cooldown_timer_done():
	third_skill_cooldown = false


func enemy_slowdown():
	if third_skill_cooldown:
		return
	third_skill_cooldown = true
	third_skill_cooldown_timer.start()
	for enemy in enemies:
		enemy.speed = enemy.speed / 4


