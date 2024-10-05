extends CharacterBody3D

signal hit_left
signal hit_right
signal destroyed

func _physics_process(_delta: float) -> void:
	if $LeftRayCast.is_colliding():
		hit_left.emit()
	elif $RightRayCast.is_colliding():
		hit_right.emit()


func damage() -> void:
	for critter in $Critters.get_children():
		critter.bound = false
		critter.reparent(get_parent())
		critter.top_level = true
	destroyed.emit()
	queue_free()


func _on_shot_timer_timeout() -> void:
	var bullet := preload("res://enemies/enemy_bullet.tscn").instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $MuzzleMarker.global_position
	bullet.top_level = true
	
