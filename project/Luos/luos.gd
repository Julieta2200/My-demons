class_name Luos extends CharacterBody2D

const speed = 300

var _freeze: bool

func _physics_process(delta):
	move()

func move():
	if _freeze:
		return
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.flip_h = direction < 0
		$AnimatedSprite2D.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		$AnimatedSprite2D.play("idle")
	move_and_slide()

func freeze():
	_freeze = true
	velocity.x = move_toward(velocity.x, 0, speed)
	$AnimatedSprite2D.play("idle")

func unfreeze():
	_freeze = false
