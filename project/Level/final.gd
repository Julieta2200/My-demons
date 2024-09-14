extends Node2D

var luos_sprite_scene = preload("res://project/SpriteFrames/luos_sprite.tscn")
var explosion_scene = preload("res://project/Enemy/explosion.tscn")
var lilith_sprite_scene = preload("res://project/SpriteFrames/lilith_sprite.tscn")
var gary_sprite_scene = preload("res://project/SpriteFrames/gary_sprite.tscn")
var ina_sprite_scene = preload("res://project/SpriteFrames/ina_sprite.tscn")


func start_monolog():
	BgMusic.play()
	show_dialog("It’s nice to know everyone is okay now.")
	await get_tree().create_timer(4).timeout
	show_dialog("That was a really long night…")
	await get_tree().create_timer(3).timeout
	show_dialog("Everyone can rest now.")
	await get_tree().create_timer(3).timeout
	show_dialog("But why do I still feel this way?")
	await get_tree().create_timer(3).timeout
	show_dialog("My thoughts are a mess right now…")
	await get_tree().create_timer(3).timeout
	show_dialog("Sometimes, they’re like a boomerang. Even when I try to let them go, they keep coming back.")
	$circle/opacity.play("opacity")
	await get_tree().create_timer(5).timeout
	show_dialog("When I try to face them, they seem unbreakable, no matter how hard I try.")
	$tanks/opacity.play("opacity")
	await get_tree().create_timer(5).timeout
	show_dialog("Sometimes, they sneak up on me in ways I don’t notice until the last second…")
	$flashs/opacity.play("opacity")
	await get_tree().create_timer(5).timeout
	show_dialog("Sometimes, they split into so many thoughts that it’s just too overwhelming.")
	$clouds/opacity.play("opacity")
	await get_tree().create_timer(5).timeout
	show_dialog("I know some thoughts need to be faced at their root.")
	await get_tree().create_timer(4).timeout
	show_dialog("And sometimes, it needs to be the right time to face them.")
	await get_tree().create_timer(4).timeout
	show_dialog("Aaaah… It’s just too much. I can’t face them all… I just can’t…")
	$AnimationPlayer.play("dimming")
	await get_tree().create_timer(8).timeout
	$CanvasLayer/Dialog.finish()
	var enemies = $tanks.get_children()
	$explosion.play()
	enemies.append_array($flashs.get_children())
	enemies.append_array($clouds.get_children())
	enemies.append_array($circle.get_children())
	for e in enemies:
		var exp = explosion_scene.instantiate()
		if e is AnimationPlayer:
			continue
		exp.global_position = e.global_position
		add_child(exp)
		e.visible = false
	$AnimationPlayer.play("shining")
	await get_tree().create_timer(7).timeout
	show_dialog("You came back?!")
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialog.talk("We were always with you...",
	"Ina", ina_sprite_scene,
	true)
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialog.talk("What a night, haha.",
	"Gary", gary_sprite_scene,
	true)
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialog.talk("You’re safe now, Luos.",
	"Lilith", lilith_sprite_scene,
	true)
	await get_tree().create_timer(3).timeout
	show_dialog("Thank you for facing the storm with me...")
	await get_tree().create_timer(5).timeout
	$CanvasLayer/Dialog.finish()
	await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("theend")
	
	
	

func show_dialog(text: String):
	$CanvasLayer/Dialog.talk(text,
	"Luos", luos_sprite_scene,
	false)
