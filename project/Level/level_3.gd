extends Level

var wave_spawn_index = 0
var dialog_index = 0
var wave_timer: Timer
var dialog_timer: Timer

var next_dialog

var initial_dialog: Array[Dictionary] = [
	{"name": "Ina", "text": "Luos, I wish you were here with me now.", "sprite": ina_sprite_scene, "right": true},
	{"name": "Luos", "text": "I’m here for you…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Ina", "text": "I really want to help the people I care about, but I feel so useless…", "sprite": ina_sprite_scene, "right": true},
	{"name": "Ina", "text": "I’m sorry, Luos…", "sprite": ina_sprite_scene, "right": true},
]

var wave_1_dialog: Array[Dictionary] = [
	{"name": "Lilith", "text": "She’s fighting some strong demons, isn’t she?", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Luos", "text": "Ina, what’s going on? Please talk to me.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Ina", "text": "Why couldn’t I save them?", "sprite": ina_sprite_scene, "right": true},
	{"name": "Ina", "text": "It’s all my fault…", "sprite": ina_sprite_scene, "right": true},
]

var wave_2_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Ina, you saved me!!!", "sprite": luos_sprite_scene, "right": false},
	{"name": "Ina", "text": " I promised I would save them…", "sprite": ina_sprite_scene, "right": true},
	{"name": "Ina", "text": "I keep seeing their faces when I’m sleeping. I promised…", "sprite": ina_sprite_scene, "right": true},
	{"name": "Gary", "text": "Aaah, this is too scary!", "sprite": gary_sprite_scene, "right": false},
]

var wave_3_dialog: Array[Dictionary] = [
	{"name": "Ina", "text": "Luos, I remember your smile the last time we met.", "sprite": ina_sprite_scene, "right": true},
	{"name": "Ina", "text": "I was so happy to see you back on your feet.", "sprite": ina_sprite_scene, "right": true},
	{"name": "Luos", "text": "I’m always happy when I see you too, Ina! You took such good care of me.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "Thank you for saving Luos, Ina…", "sprite": lilith_sprite_scene, "right": false},
]

@onready var hearts = $CanvasLayer/hearts

func _ready():
	super._ready()
	wave_timer = Timer.new()
	wave_timer.wait_time = 1
	add_child(wave_timer)
	clock_left = $clock/c_left
	clock_right = $clock/c_right
	dialog_timer = Timer.new()
	dialog_timer.wait_time = 3
	add_child(dialog_timer)
	next_dialog = initial_dialog
	
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
	else:
		spawn_tank()
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
	if rand < 0.35:
		spawn_boomerang()
	elif rand < 0.5:
		spawn_cloud()
	else:
		spawn_flash()
		
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
		spawn_boomerang()
	else:
		spawn_flash()
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


