class_name Dialog extends Control

var sounds = [
	preload("res://assets/SFX/talk1.mp3"),
	preload("res://assets/SFX/talk2.mp3"),
	preload("res://assets/SFX/talk3.mp3"),
	preload("res://assets/SFX/talk4.mp3"),
	preload("res://assets/SFX/talk5.mp3")
]

@onready var left_panel: Dictionary = {
	"title": $Panel/title,
	"text": $Panel/RichTextLabel,
	"container": $Panel/sprite_container,
	"panel": $Panel
}

@onready var right_panel: Dictionary = {
	"title": $Reverse/title,
	"text": $Reverse/RichTextLabel,
	"container": $Reverse/sprite_container,
	"panel": $Reverse
}

func talk(text: String, name: String, image: Resource, right: bool = false):
	var r = randi_range(0, 4)
	$sound.stream = sounds[r]
	$sound.play()
	left_panel["panel"].visible = false
	right_panel["panel"].visible = false
	var panel = left_panel
	if right:
		panel = right_panel
	panel["text"].text = text
	panel["title"].text = name
	var old_sprites = panel["container"].get_children()
	for os in old_sprites:
		os.queue_free()
	var sprite = image.instantiate()
	sprite.flip_h = right
	panel["container"].add_child(sprite)
	panel["panel"].visible = true

func finish():
	left_panel["panel"].visible = false
	right_panel["panel"].visible = false
