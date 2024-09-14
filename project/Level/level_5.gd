extends Level

var wave_spawn_index = 0
var dialog_index = 0
var wave_timer: Timer
var dialog_timer: Timer

var next_dialog

var initial_dialog: Array[Dictionary] = [
	{"name": "Ori", "text": "I just need to survive until morning…", "sprite": ori_sprite_scene, "right": true},
	{"name": "Luos", "text": "Ori, what’s happening?", "sprite": luos_sprite_scene, "right": false},
	{"name": "Ori", "text": "Luos… Every day I try to tell you, but I can’t bring myself to do it.", "sprite": ori_sprite_scene, "right": true},
	{"name": "Luos", "text": "I’m here, Ori…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Ori", "text": "Sometimes, it feels like it’s all too much…", "sprite": ori_sprite_scene, "right": true},
]

var wave_1_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Talk with me, Ori.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Ori", "text": "I just need to hold on until morning. In the morning, I’ll be fine.", "sprite": ori_sprite_scene, "right": true},
	{"name": "Ori", "text": "These sleepless nights are really wearing me down. It feels like I’m stuck in a room with a monster.", "sprite": ori_sprite_scene, "right": true},
	{"name": "Ori", "text": "And I’m all alone in that nightmare…", "sprite": ori_sprite_scene, "right": true},
]

var wave_2_dialog: Array[Dictionary] =  [
	{"name": "Luos", "text": "Ori, I’m here to help you. Mom and Dad will help you too.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Ori", "text": "I don’t want to make you worry.", "sprite": ori_sprite_scene, "right": true},
	{"name": "Ori", "text": "It’s just too much right now, and I don’t want to be a burden.", "sprite": ori_sprite_scene, "right": true},
	{"name": "Ori", "text": "I’ll need to put on a smile in the morning…", "sprite": ori_sprite_scene, "right": true},
]

var wave_3_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Ori, we don’t want you to hide your sadness.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "It’s okay to be sad. Everyone who cares about you wants you to be genuinely happy.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "Not just to pretend to be happy…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "If you’re sad, it’s okay to feel that way, and I want to be here with you through it.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "If you’re happy, I want to share that happiness with you too.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "Everyone feels that way…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Ori", "text": "I need your help, Luos…", "sprite": ori_sprite_scene, "right": true},
]

func _ready():
	super._ready()
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
		spawn_cloud()
	elif rand < 0.5:
#		spawn_cloud()
		spawn_tank()
	else:
		spawn_clock()
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
		spawn_clock()
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
		spawn_clock()
		
	elif rand < 0.5:
		spawn_wall()
	else:
		spawn_tank()
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
	VillageManager.set_state(VillageManager.STATES.ORI)
	get_tree().change_scene_to_file("res://project/Level/village.tscn")

