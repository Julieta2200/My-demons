extends Level

var wave_spawn_index = 0
var wave_timer: Timer

func _on_wave_1_start_timeout():
	wave_timer = Timer.new()
	wave_timer.wait_time = 1
	add_child(wave_timer)
	wave_timer.connect("timeout", wave_1_interval)
	wave_timer.start()

func wave_1_interval():
	spawn_boomerang()
	wave_spawn_index += 1
	if wave_spawn_index == 10:
		print("wave 2")
		wave_spawn_index = 0
		wave_timer.disconnect("timeout", wave_1_interval)
		wave_timer.connect("timeout", wave_2_interval)
	
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
		wave_timer.connect("timeout", wave_3_interval)
		
func wave_3_interval():
	var rand = randf()
	wave_spawn_index += 1
	if rand < 0.35:
		spawn_cloud()
	else:
		spawn_boomerang()
	if wave_spawn_index == 20:
		wave_timer.paused = true
		print("wave 3")
