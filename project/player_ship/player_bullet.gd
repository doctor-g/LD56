extends CharacterBody3D

@export var speed := 12.0

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(Vector3(0, 0, -speed * delta))
	if collision != null:
		for i in collision.get_collision_count():
			var collider = collision.get_collider(i)
			if collider.is_in_group("enemies"):
				collider.damage()
				queue_free()
