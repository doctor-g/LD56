class_name PlayerShip extends CharacterBody3D

var speed := 8.0

var _can_fire := true
var _can_bubble := true

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	move_and_collide(velocity * delta)
	
	if Input.is_action_pressed("fire") and _can_fire:
		var projectile := preload("res://player_ship/player_bullet.tscn").instantiate()
		get_parent().add_child(projectile)
		projectile.global_position = $MuzzleMarker.global_position
		_can_fire = false
		$ShotTimer.start()
	
	if Input.is_action_just_pressed("launch_bubble") and _can_bubble:
		var bubble := preload("res://player_ship/bubble.tscn").instantiate()
		get_parent().add_child(bubble)
		bubble.global_position = $MuzzleMarker.global_position
		_can_bubble = false
		$BubbleTimer.start()
	
	

func _on_shot_timer_timeout() -> void:
	_can_fire = true


func _on_bubble_timer_timeout() -> void:
	_can_bubble = true
