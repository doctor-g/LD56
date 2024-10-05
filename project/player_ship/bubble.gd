extends Area3D

@export var speed := 9.5

func _physics_process(delta: float) -> void:
	# Move forward
	position.z -= speed * delta


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("critters"):
		print("Capture!")
		body.queue_free()
		queue_free()
	else:
		print("Pop!")
		queue_free()
		
