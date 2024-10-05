extends Marker3D

var first_wave_size := 1
var max_wave_size := 5

var _waves_spawned := 0

func _ready() -> void:
	_spawn_mob()


func _spawn_mob() -> void:
	var wave := preload("res://enemies/wave.tscn").instantiate()
	# "_waves_spawned / 2" gives a sequence 1 1 2 2 3 3 4 4 5 5. Pretty good.
	@warning_ignore("integer_division")
	wave.size = mini(_waves_spawned / 2 + 1, max_wave_size)
	add_child(wave)
	wave.global_position = global_position
	wave.descend()
	
	_waves_spawned += 1


func _on_mob_spawn_timer_timeout() -> void:
	_spawn_mob()
