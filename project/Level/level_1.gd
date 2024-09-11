extends Level

var wave_spawn_index = 0
var dialog_index = 0
var wave_timer: Timer
var dialog_timer: Timer

var initial_dialog: Array[Dictionary] = [
	{"name": "Lilith", "text": "I don’t know why I’m thinking about you right now.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "I’m here for you, Lilith.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "You’ve always been so kind and calm. Sometimes, that helped me get through the day.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Lilith", "text": "My grades are getting worse, and I keep letting everyone down.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "That’s not true at all!", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "My parents tried their best to support me, but I keep failing.", "sprite": lilith_sprite_scene, "right": true},
]

var wave_1_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Everyone is proud of you, no matter what.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "I don’t think that’s true…", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "No one has any expectations of you.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "The only thing I want is for you to be happy. Nothing else matters.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "But what about my parents…", "sprite": lilith_sprite_scene, "right": true},
]

var wave_2_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Your parents love you no matter what.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "They always seem angry.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "Try talking to them about how you feel. They need to understand.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "I just can’t do that.", "sprite": lilith_sprite_scene, "right": true},
]

var wave_3_dialog: Array[Dictionary] = [
	{"name": "Lilith", "text": "Your parents love you no matter what.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Lilith", "text": "Dad used to play with me all the time…", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Lilith", "text": "I want to talk to them and get their help.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "They’ll be happy to help you, Lilith…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "Thank you, Luos. You’ve always been a great friend I can trust.", "sprite": lilith_sprite_scene, "right": true},
]

@onready var hearts = $CanvasLayer/hearts

func _ready():
	super._ready()
	wave_timer = Timer.new()
	wave_timer.wait_time = 6
	add_child(wave_timer)
	clock_left = $clock/c_left
	clock_right = $clock/c_right
	dialog_timer = Timer.new()
	dialog_timer.wait_time = 3
	add_child(dialog_timer)

func _on_dialog_start_timeout():
	dialog_timer.connect("timeout", show_initial_dialog)
	start_dialog(initial_dialog)
	

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
	spawn_boomerang()
	wave_spawn_index += 1
	if wave_spawn_index == 10:
		wave_spawn_index = 0
		wave_timer.disconnect("timeout", wave_1_interval)
		wave_timer.stop()
		await get_tree().create_timer(6).timeout
		start_dialog(wave_1_dialog)
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
	else:
		spawn_boomerang()
	if wave_spawn_index == 15:
		wave_spawn_index = 0
		wave_timer.disconnect("timeout", wave_2_interval)
		wave_timer.stop()
		await get_tree().create_timer(6).timeout
		start_dialog(wave_2_dialog)
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
	else:
		spawn_boomerang()
	if wave_spawn_index == 20:
		wave_spawn_index = 0
		wave_timer.disconnect("timeout", wave_3_interval)
		wave_timer.stop()
		await get_tree().create_timer(6).timeout
		start_dialog(wave_3_dialog)
		dialog_timer.connect("timeout", show_wave_3_dialog)

func show_wave_3_dialog():
	dialog_index += 1
	if dialog_index == wave_3_dialog.size():
		dialog_index = 0
		dialog_timer.disconnect("timeout", show_wave_3_dialog)
		dialog_timer.stop()
		return
	
	$CanvasLayer/Dialog.talk(wave_3_dialog[dialog_index]["text"],
	wave_3_dialog[dialog_index]["name"], wave_3_dialog[dialog_index]["sprite"],
	wave_3_dialog[dialog_index]["right"])

func start_dialog(dialogs):
	$CanvasLayer/Dialog.talk(dialogs[dialog_index]["text"],
	 dialogs[dialog_index]["name"], dialogs[dialog_index]["sprite"],
	dialogs[dialog_index]["right"])
	dialog_timer.start()


func start_wave(wave: Callable):
	wave_timer.connect("timeout", wave)
	wave_timer.start()
	$CanvasLayer/Dialog.finish()




