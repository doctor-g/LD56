extends CharacterBody3D

func damage() -> void:
	for critter in $Critters.get_children():
		critter.bound = false
		critter.reparent(get_parent())
	queue_free()


func _on_shot_timer_timeout() -> void:
	var bullet := preload("res://enemies/enemy_bullet.tscn").instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $MuzzleMarker.global_position
	
