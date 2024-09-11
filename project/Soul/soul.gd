extends StaticBody2D

var hp: int = 3

func _on_area_2d_area_entered(area):
	area.get_parent().delete()
	hp -= 1
	print(hp)

	
