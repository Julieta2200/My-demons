extends Node2D

@onready var luos: Luos = $luos
@onready var dialog_box: Dialog = $CanvasLayer/Dialog
@onready var dialog_timer: Timer = $dialog_timer

@onready var lilith_position: Marker2D = $positions/lilith
@onready var lilith_area: Area2D = $lilith_area

@onready var gary_positon: Marker2D = $positions/gary
@onready var gary_area: Area2D = $gary_area

@onready var ina_positon: Marker2D = $positions/ina
@onready var ina_area: Area2D = $ina_area

@onready var shiny_positon: Marker2D = $positions/shiny
@onready var shiny_area: Area2D = $shiny_area

@onready var ori_positon: Marker2D = $positions/ori
@onready var ori_area: Area2D = $ori_area

var dialog_index: int
var dialog
var level: String

var luos_sprite_scene = preload("res://project/SpriteFrames/luos_sprite.tscn")
var lilith_sprite_scene = preload("res://project/SpriteFrames/lilith_sprite.tscn")
var gary_sprite_scene = preload("res://project/SpriteFrames/gary_sprite.tscn")
var ina_sprite_scene = preload("res://project/SpriteFrames/ina_sprite.tscn")
var shiny_sprite_scene = preload("res://project/SpriteFrames/shiny_sprite.tscn")



var lilith_start_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Lilith, I don’t know what’s happening.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "Can’t you hear me?", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "Lilith...", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "Sometimes, it all feels like too much…", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "What feels like too much? What’s happening?", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "I’m okay for now, but tomorrow morning, it’ll all start again…", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Lilith", "text": "I don’t want the sun to come up.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "I’m here for you, Lilith. Please, try to hear me…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "Luos...", "sprite": lilith_sprite_scene, "right": true},
]

var lilith_end_dialog: Array[Dictionary] = [
	{"name": "Lilith", "text": "What’s going on?", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "I’m not sure. I just woke up like this.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Luos", "text": "How are you feeling, Lilith?", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "It’s strange, but I feel calm now. I guess you’ve been here the whole time.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "Yes…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "I felt like you were nearby, as if I was talking to you.", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "I’m not sure what’s happening, but we need to find someone who can help", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "I’ll join you. It’s not like I can do much else without my body, haha", "sprite": lilith_sprite_scene, "right": true},
]

var gary_start_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Lilith, isn’t that Gary?", "sprite": luos_sprite_scene, "right": false},	
	{"name": "Lilith", "text": "Yes, it’s him. What’s he doing here so late?", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Gary", "text": "Aaah, why do I keep doing this?", "sprite": gary_sprite_scene, "right": true},
	{"name": "Lilith", "text": "What’s wrong with him?", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Luos", "text": "Gary, we’re here. Please, listen to us.", "sprite": luos_sprite_scene, "right": false},
]

var gary_end_dialog: Array[Dictionary] = [
	{"name": "Lilith", "text": "That was quite a roller coaster.", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Gary", "text": "Yes, I’m sorry about that.", "sprite": gary_sprite_scene, "right": true},
	{"name": "Luos", "text": "It’s not your fault, Gary. You don’t need to apologize.", "sprite": luos_sprite_scene, "right": false},	
	{"name": "Gary", "text": "Anyway, what’s going on? Why can I see myself sleeping over there?", "sprite": gary_sprite_scene, "right": true},
	{"name": "Luos", "text": "We’re not sure yet, but it’s a bit scary.", "sprite": luos_sprite_scene, "right": false},
]

var ina_start_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "Ina, you too…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Gary", "text": "You too what?", "sprite": gary_sprite_scene, "right": false},
	{"name": "Lilith", "text": "Do you know her, Luos?", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Luos", "text": "She’s my good friend and also my doctor who took care of me when I was ill.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "She seems sad.", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Ina", "text": "It’s pointless…", "sprite": ina_sprite_scene, "right": true},
]

var ina_end_dialog: Array[Dictionary] = [
	{"name": "Ina", "text": "Sorry about all that, kids.", "sprite": ina_sprite_scene, "right": true},
	{"name": "Gary", "text": "We’re kind of getting used to it, haha.", "sprite": gary_sprite_scene, "right": false},
	{"name": "Ina", "text": "So, what’s going on here?", "sprite": ina_sprite_scene, "right": true},
	{"name": "Luos", "text": "We’re trying to figure it out, but I’m glad we ran into you…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Lilith", "text": "Let’s move on.", "sprite": lilith_sprite_scene, "right": false},
]

var shiny_start_dialog: Array[Dictionary] = [
	{"name": "Ina", "text": "Who’s that kid over there?", "sprite": ina_sprite_scene, "right": false},
	{"name": "Luos", "text": "No idea, but I think we should be ready for another wave of demons.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Gary", "text": "I think he’s new in town.", "sprite": gary_sprite_scene, "right": false},
	{"name": "Shiny", "text": "That’s annoying…", "sprite": shiny_sprite_scene, "right": true},
]

var shiny_end_dialog: Array[Dictionary] = [
	{"name": "Gary", "text": "Shiny, can you hear me?", "sprite": gary_sprite_scene, "right": false},
	{"name": "Lilith", "text": "He’s still sleeping.", "sprite": lilith_sprite_scene, "right": false},
	{"name": "Luos", "text": "Let him rest. He had a tough battle.", "sprite": luos_sprite_scene, "right": false},
	{"name": "Gary", "text": "See you later, friend…", "sprite": gary_sprite_scene, "right": false},
	{"name": "Lilith", "text": "That’s so sweet, Gary!", "sprite": lilith_sprite_scene, "right": false},
]

var ori_start_dialog: Array[Dictionary] = [
	{"name": "Luos", "text": "What’s Ori doing here?", "sprite": luos_sprite_scene, "right": false},
	{"name": "Gary", "text": "He seems sad…", "sprite": gary_sprite_scene, "right": false},
	{"name": "Luos", "text": "Brother…", "sprite": luos_sprite_scene, "right": false},
]

var ori_end_dialog: Array[Dictionary] = [
	{"name": "Lilith", "text": "You’re a good brother, Luos…", "sprite": lilith_sprite_scene, "right": true},
	{"name": "Luos", "text": "I’m just happy I can help…", "sprite": luos_sprite_scene, "right": false},
	{"name": "Gary", "text": "You’re always so calm. I’m a bit jealous, haha", "sprite": gary_sprite_scene, "right": true},
	{"name": "Ina", "text": "What’s going on?", "sprite": ina_sprite_scene, "right": true},
	{"name": "Luos", "text": "I think we’re heading back…", "sprite": luos_sprite_scene, "right": false},	
]

func _ready():
	BgMusic.stop()
	match VillageManager.get_state():
		VillageManager.STATES.LILITH:
			prepare_lilith_state()
		VillageManager.STATES.GARY:
			prepare_gary_state()
		VillageManager.STATES.INA:
			prepare_ina_state()
		VillageManager.STATES.SHINY:
			prepare_shiny_state()
		VillageManager.STATES.ORI:
			prepare_ori_state()
	

func prepare_lilith_state():
	lilith_area.queue_free()
	luos.global_position = lilith_position.global_position
	luos.freeze()
	start_dialog(lilith_end_dialog)
	
func prepare_gary_state():
	lilith_area.queue_free()
	gary_area.queue_free()
	luos.global_position = gary_positon.global_position
	luos.freeze()
	start_dialog(gary_end_dialog)

func prepare_ina_state():
	lilith_area.queue_free()
	gary_area.queue_free()
	ina_area.queue_free()
	luos.global_position = ina_positon.global_position
	luos.freeze()
	start_dialog(ina_end_dialog)

func prepare_shiny_state():
	lilith_area.queue_free()
	gary_area.queue_free()
	ina_area.queue_free()
	shiny_area.queue_free()
	luos.global_position = shiny_positon.global_position
	luos.freeze()
	start_dialog(shiny_end_dialog)

func prepare_ori_state():
	lilith_area.queue_free()
	gary_area.queue_free()
	ina_area.queue_free()
	shiny_area.queue_free()
	ori_area.queue_free()
	luos.global_position = ori_positon.global_position
	luos.freeze()
	$light.play("lightup")
	start_dialog(ori_end_dialog)

func start_dialog(d):
	dialog = d
	dialog_box.talk(dialog[dialog_index]["text"],
	dialog[dialog_index]["name"], dialog[dialog_index]["sprite"],
	dialog[dialog_index]["right"])
	dialog_timer.start()


func _on_dialog_timer_timeout():
	dialog_index += 1
	if dialog_index == dialog.size():
		dialog_index = 0
		dialog_timer.stop()
		dialog_box.finish()
		dialog_finished()
		return
	dialog_box.talk(dialog[dialog_index]["text"],
	dialog[dialog_index]["name"], dialog[dialog_index]["sprite"],
	dialog[dialog_index]["right"])

func dialog_finished():
	match dialog:
		lilith_start_dialog, gary_start_dialog, ina_start_dialog, shiny_start_dialog, ori_start_dialog:
			get_tree().change_scene_to_file(level)
		lilith_end_dialog, gary_end_dialog, ina_end_dialog, shiny_end_dialog:
			luos.unfreeze()
		ori_end_dialog:
			final_level()

func final_level():
	get_tree().change_scene_to_file("res://project/Level/final.tscn")

func _on_lilith_area_body_entered(body):
	luos.freeze()
	level = "res://project/Level/level_1.tscn"
	start_dialog(lilith_start_dialog)

func _on_gary_area_body_entered(body):
	luos.freeze()
	level = "res://project/Level/level_2.tscn"
	start_dialog(gary_start_dialog)


func _on_ina_area_body_entered(body):
	luos.freeze()
	level = "res://project/Level/level_3.tscn"
	start_dialog(ina_start_dialog)


func _on_shiny_area_body_entered(body):
	luos.freeze()
	level = "res://project/Level/level_4.tscn"
	start_dialog(shiny_start_dialog)


func _on_ori_area_body_entered(body):
	luos.freeze()
	level = "res://project/Level/level_5.tscn"
	start_dialog(ori_start_dialog)
