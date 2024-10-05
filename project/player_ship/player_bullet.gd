extends CharacterBody2D

@export var speed := 650.0


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(Vector2.UP * speed * delta)
	if collision != null:
		collision.get_collider().damage()
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
