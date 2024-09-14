extends Level

var wave_spawn_index = 0
var dialog_index = 0
var wave_timer: Timer
var dialog_timer: Timer

var next_dialog

var initial_dialog: Array[Dictionary] = [
	{"name": "Ina", "text": "Oh no! Not this nightmare again…", "sprite": ina_sprite_scene, "right": false},
	{"name": "Luos", "text": "Don’t worry, Ina. You’re not the target this time.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Shiny", "text": "Great, now I’m hearing voices…", "sprite": shiny_sprite_scene, "right": true},
	{"name": "Gary", "text": "It’s not your imagination. We’re here.", "sprite": gary_sprite_scene, "right": false},
	{"name": "Shiny", "text": "It’s because I can’t make any friends…", "sprite": shiny_sprite_scene, "right": true},
]

var wave_1_dialog: Array[Dictionary] = [
	{"name": "Lilith", "text": "We’re not just your imagination. Talk to us!", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Shiny", "text": "We always keep moving from place to place…", "sprite": shiny_sprite_scene, "right": true},
	{"name": "Shiny", "text": "It’s so frustrating! I can’t make any friends…", "sprite": shiny_sprite_scene, "right": true},
	{"name": "Shiny", "text": "Even when I do make new friends, we end up moving away…", "sprite": shiny_sprite_scene, "right": true},
]

var wave_2_dialog: Array[Dictionary] = [
	{"name": "Gary", "text": "I can be your friend!", "sprite": gary_sprite_scene, "right": false},
	{"name": "Shiny", "text": "What’s the point?", "sprite": shiny_sprite_scene, "right": true},
	{"name": "Shiny", "text": "What’s the point of anything at all…", "sprite": shiny_sprite_scene, "right": true},
]

var wave_3_dialog: Array[Dictionary] = [
	{"name": "Shiny", "text": "Why are you protecting me?", "sprite": shiny_sprite_scene, "right": true},
	{"name": "Lilith", "text": "What else should we do?", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Gary", "text": "Your soul is very beautiful. I want to be your friend!", "sprite": gary_sprite_scene, "right": false},
	{"name": "Shiny", "text": "Sometimes it gets lonely…", "sprite": shiny_sprite_scene, "right": true},
	{"name": "Shiny", "text": "But it’s nice to make new friends.", "sprite": shiny_sprite_scene, "right": true},
	{"name": "Shiny", "text": "Even if I move, can we still be friends?", "sprite": shiny_sprite_scene, "right": true},
	{"name": "Gary", "text": "Aaah, of course we can!", "sprite": gary_sprite_scene, "right": false},
]

func _ready():
	super._ready()
	$CanvasLayer/support.skill(0)
	$CanvasLayer/support.skill(2)
	wave_timer = Timer.new()
	wave_timer.wait_time = 1
	add_child(wave_timer)
	clock_left = $clock/c_left
	clock_right = $clock/c_right
	wall_left = $wall_points/left
	wall_right = $wall_points/right
	dialog_timer = Timer.new()
	dialog_timer.wait_time = 3
	add_child(dialog_timer)
	next_dialog = initial_dialog

func _on_second_skill_cooldown_timer_done():
	super._on_second_skill_cooldown_timer_done()
	$CanvasLayer/support.skill(1)

func _on_third_skill_cooldown_timer_done():
	super._on_third_skill_cooldown_timer_done()
	$CanvasLayer/support.skill(2)
	
func _on_dialog_start_timeout():
	dialog_timer.connect("timeout", show_initial_dialog)
	start_dialog()
	

func show_initial_dialog():
	dialog_index += 1
	if dialog_index == initial_dialog.size():
		dialog_index = 0
		dialog_timer.disconnect("timeout", show_initial_dialog)
		dialog_timer.stop()
		start_wave(wave_1_interval)
		return
	
	$CanvasLayer/Dialog.talk(initial_dialog[dialog_index]["text"],
	initial_dialog[dialog_index]["name"], initial_dialog[dialog_index]["sprite"],
	initial_dialog[dialog_index]["right"])

func wave_1_interval():
	var rand = randf()
	wave_spawn_index += 1
	if rand < 0.25:
		spawn_boomerang()
	elif rand < 0.5:
		spawn_cloud()
	else:
		spawn_wall()
	if wave_spawn_index == 10:
		wave_spawn_index = 0
		wave_timer.disconnect("timeout", wave_1_interval)
		wave_timer.stop()
		$PointLight2D.texture_scale = 0.65
		wave_finished = true
		next_dialog = wave_1_dialog
		dialog_timer.connect("timeout", show_wave_1_dialog)

func show_wave_1_dialog():
	dialog_index += 1
	if dialog_index == wave_1_dialog.size():
		dialog_index = 0
		dialog_timer.disconnect("timeout", show_wave_1_dialog)
		dialog_timer.stop()
		start_wave(wave_2_interval)
		return
	
	$CanvasLayer/Dialog.talk(wave_1_dialog[dialog_index]["text"],
	wave_1_dialog[dialog_index]["name"], wave_1_dialog[dialog_index]["sprite"],
	wave_1_dialog[dialog_index]["right"])

func wave_2_interval():
	var rand = randf()
	wave_spawn_index += 1
	if rand < 0.25:
		spawn_cloud()
	elif rand < 0.5:
		spawn_flash()
	else:
		spawn_wall()
		
	if wave_spawn_index == 15:
		wave_spawn_index = 0
		wave_timer.disconnect("timeout", wave_2_interval)
		wave_timer.stop()
		$PointLight2D.texture_scale = 0.8
		next_dialog = wave_2_dialog
		wave_finished = true
		dialog_timer.connect("timeout", show_wave_2_dialog)

func show_wave_2_dialog():
	dialog_index += 1
	if dialog_index == wave_2_dialog.size():
		dialog_index = 0
		dialog_timer.disconnect("timeout", show_wave_2_dialog)
		dialog_timer.stop()
		start_wave(wave_3_interval)
		return
	
	$CanvasLayer/Dialog.talk(wave_2_dialog[dialog_index]["text"],
	wave_2_dialog[dialog_index]["name"], wave_2_dialog[dialog_index]["sprite"],
	wave_2_dialog[dialog_index]["right"])

func wave_3_interval():
	var rand = randf()
	wave_spawn_index += 1
	if rand < 0.35:
		spawn_cloud()
	elif rand < 0.5:
		spawn_tank()
	else:
		spawn_wall()
	if wave_spawn_index == 20:
		wave_spawn_index = 0
		wave_timer.disconnect("timeout", wave_3_interval)
		wave_timer.stop()
		$PointLight2D.texture_scale = 1
		next_dialog = wave_3_dialog
		wave_finished = true
		dialog_timer.connect("timeout", show_wave_3_dialog)

func show_wave_3_dialog():
	dialog_index += 1
	if dialog_index == wave_3_dialog.size():
		dialog_index = 0
		dialog_timer.disconnect("timeout", show_wave_3_dialog)
		dialog_timer.stop()
		$AnimationPlayer.play("Finish")
		return
	
	$CanvasLayer/Dialog.talk(wave_3_dialog[dialog_index]["text"],
	wave_3_dialog[dialog_index]["name"], wave_3_dialog[dialog_index]["sprite"],
	wave_3_dialog[dialog_index]["right"])

func start_dialog():
	wave_finished = false
	$CanvasLayer/Dialog.talk(next_dialog[dialog_index]["text"],
	next_dialog[dialog_index]["name"], next_dialog[dialog_index]["sprite"],
	next_dialog[dialog_index]["right"])
	dialog_timer.start()


func start_wave(wave: Callable):
	wave_timer.connect("timeout", wave)
	wave_timer.start()
	$CanvasLayer/Dialog.finish()

func start_next_leve():
	VillageManager.set_state(VillageManager.STATES.SHINY)
	get_tree().change_scene_to_file("res://project/Level/village.tscn")

