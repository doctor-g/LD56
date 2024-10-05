class_name PlayerShip extends CharacterBody3D

signal exploded

var speed := 8.0

var _can_fire := true
var _can_bubble := true

var _alive := true
var _meshes := [$hull_cockpitPoint, $hull_body, $attachment_barrelEnd]

func _physics_process(delta: float) -> void:
	if not _alive:
		return
	
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	var collisions := move_and_collide(velocity * delta)
	if collisions != null:
		for i in collisions.get_collision_count():
			var collider := collisions.get_collider(i)
			if collider.is_in_group("enemies"):
				damage()
				break
	
	if Input.is_action_pressed("fire") and _can_fire:
		var projectile := preload("res://player_ship/player_bullet.tscn").instantiate()
		get_parent().add_child(projectile)
		projectile.global_position = $MuzzleMarker.global_position
		_can_fire = false
		Sfx.play_laser()
		$ShotTimer.start()
	
	if Input.is_action_just_pressed("launch_bubble") and _can_bubble:
		var bubble := preload("res://player_ship/bubble.tscn").instantiate()
		get_parent().add_child(bubble)
		bubble.global_position = $MuzzleMarker.global_position
		_can_bubble = false
		Sfx.play_bubble()
		$BubbleTimer.start()
	
	
func damage() -> void:
	if not _alive:
		return
	
	Sfx.play_player_explosion()
	_alive = false
	$CollisionShape3D.set_deferred("disabled", true)
	$ExplosionParticles.visible = true
	$ExplosionParticles.emitting = true
	
	for mesh in _meshes:
		await get_tree().create_timer(0.2).timeout
		mesh.visible = false


func _on_shot_timer_timeout() -> void:
	_can_fire = true


func _on_bubble_timer_timeout() -> void:
	_can_bubble = true


func _on_explosion_particles_finished() -> void:
	exploded.emit()
