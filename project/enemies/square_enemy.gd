extends CharacterBody3D

signal hit_left
signal hit_right
signal destroyed

var mean_time_between_shots := 1.5
var deviation_between_shots := 0.3

func _ready() -> void:
	_prepare_next_shot()


func _physics_process(_delta: float) -> void:
	if $LeftRayCast.is_colliding():
		hit_left.emit()
	elif $RightRayCast.is_colliding():
		hit_right.emit()


func damage() -> void:
	for critter in $Critters.get_children():
		critter.bound = false
		# I need these at the top level so that they don't 
		# disappear when the mob is freed.
		critter.reparent(get_tree().root)
		critter.top_level = true
	destroyed.emit()
	Sfx.play_break_apart()
	queue_free()


func _prepare_next_shot() -> void:
	var duration := randfn(mean_time_between_shots, deviation_between_shots)
	await get_tree().create_timer(duration).timeout
	_shoot()


func _shoot() -> void:
	var bullet := preload("res://enemies/enemy_bullet.tscn").instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $MuzzleMarker.global_position
	bullet.top_level = true
	Sfx.play_enemy_laser()
	_prepare_next_shot()


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
