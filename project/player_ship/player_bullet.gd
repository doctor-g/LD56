class_name PlayerBullet extends CharacterBody3D

@export var speed := 12.0

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(Vector3(0, 0, -speed * delta))
	if collision != null:
		for i in collision.get_collision_count():
			var collider = collision.get_collider(i)
			if collider.has_method("damage"):
				collider.damage()
				queue_free()


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
