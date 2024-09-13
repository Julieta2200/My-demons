class_name Dialog extends Control

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
