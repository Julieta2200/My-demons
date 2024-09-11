extends StaticBody2D

var hp: int = 3
var iframe: bool

func _on_area_2d_area_entered(area):
	area.get_parent().touched_soul()
	if !iframe:
		$"..".hearts.remove()
		$AnimatedSprite2D/AnimationPlayer.play("iframe")
		iframe = true
	

func iframe_finished():
	iframe = false
