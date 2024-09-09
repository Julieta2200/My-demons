extends Level

var wave_1_spawn_index = 0
var wave_timer: Timer

func _on_wave_1_start_timeout():
	wave_timer = Timer.new()
	wave_timer.wait_time = 1.8
	add_child(wave_timer)
	wave_timer.connect("timeout", wave_1_interval)
	wave_timer.start()

func wave_1_interval():
	spawn_cloud()
	wave_1_spawn_index += 1
	if wave_1_spawn_index == 10:
		wave_timer.paused = true
	
