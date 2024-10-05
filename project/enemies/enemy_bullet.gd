extends Node3D

const SPEED := 9.0

func _physics_process(delta: float) -> void:
	position.z += delta * SPEED


func _on_body_entered(body: Node3D) -> void:
	body.damage()
	queue_free()


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
