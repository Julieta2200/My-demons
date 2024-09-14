extends Level

var wave_spawn_index = 0
var dialog_index = 0
var wave_timer: Timer
var dialog_timer: Timer

var next_dialog

var initial_dialog: Array[Dictionary] = [
	{"name": "Gary", "text": "Luos, Lilith, what are you doing here?", "sprite": gary_sprite_scene, "right": true},
	{"name": "Luos", "text": "Wait, do you know where this place is?", "sprite": luos_sprite_scene, "right": false},
	{"name": "Gary", "text": "Isn’t this just my imagination? Am I going crazy?", "sprite": gary_sprite_scene, "right": true},
	{"name": "Gary", "text": "Aaah, whatever. It’s not like anyone will notice.", "sprite": gary_sprite_scene, "right": true},
	{"name": "Lilith", "text": "What do you mean?", "sprite": lilith_sprite_scene, "right": false},
]

var wave_1_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "What’s happening, Gary?", "sprite": luos_sprite_scene, "right": false},
	{"name": "Gary", "text": "Aaah, who cares?", "sprite": gary_sprite_scene, "right": true},
	{"name": "Lilith", "text": "We care, Gary. All your friends care…", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Gary", "text": "I don’t have any friends…", "sprite": gary_sprite_scene, "right": true},
]

var wave_2_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Gary, you have a lot of friends.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "Everyone in the class likes you!", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Gary", "text": "Then why do I always feel left out?", "sprite": gary_sprite_scene, "right": true},
	{"name": "Gary", "text": "When I'm around my classmates, I feel like I don’t belong. Aaah…", "sprite": gary_sprite_scene, "right": true},
]

var wave_3_dialog: Array[Dictionary] = [
	{"name": "Gary", "text": "I remember when you came to my birthday…", "sprite": gary_sprite_scene, "right": true},
	{"name": "Gary", "text": "I was really surprised and unprepared…", "sprite": gary_sprite_scene, "right": true},
	{"name": "Gary", "text": "But you didn’t care, you were so cheerful…", "sprite": gary_sprite_scene, "right": true},
	{"name": "Lilith", "text": "It was a great day, Gary.", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Gary", "text": "I don’t know why I feel this way.", "sprite": gary_sprite_scene, "right": true},
	{"name": "Luos", "text": "It’s fine Gary, we’re here with you, take your time…", "sprite": luos_sprite_scene, "right": false},
]

func _ready():
	super._ready()
	wave_timer = Timer.new()
	$CanvasLayer/support.skill(0)
	wave_timer.wait_time = 1
	add_child(wave_timer)
	clock_left = $clock/c_left
	clock_right = $clock/c_right
	dialog_timer = Timer.new()
	dialog_timer.wait_time = 3
	add_child(dialog_timer)
	next_dialog = initial_dialog
	
func _on_dialog_start_timeout():
	if !BgMusic.playing:
		BgMusic.play()
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
		spawn_flash()
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
#		spawn_cloud()
		spawn_tank()
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
#		spawn_cloud()
		spawn_tank()
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

func start_next_leve():
	VillageManager.set_state(VillageManager.STATES.GARY)
	get_tree().change_scene_to_file("res://project/Level/village.tscn")

func heal():
	pass

func enemy_slowdown():
	pass

