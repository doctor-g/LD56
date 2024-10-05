extends Area3D

@export var speed := 9.5

var _captured_critter : Node3D

@onready var _mesh := $CSGSphere3D

func _ready() -> void:
	_mesh.scale = Vector3.ZERO
	create_tween().tween_property(_mesh, "scale", Vector3.ONE, 0.5)


func _physics_process(delta: float) -> void:
	# When a critter is captured, fly up toward the camera until off screen
	if _captured_critter != null:
		position.y += 12 * delta
		# Slide the captured critter into the middle of the bubble
		_captured_critter.position = lerp(_captured_critter.position, Vector3.ZERO, 0.2)
	
	else:
		# Move forward
		position.z -= speed * delta


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	# The extra null check is required since turning off collisions is
	# deferred.
	if body.is_in_group("critters") and _captured_critter == null:
		Sfx.play_pickup()
		body.capture()
		body.reparent(self)
		$CollisionShape3D.set_deferred("disabled", false)
		_captured_critter = body
		_captured_critter.top_level = false
		$CSGSphere3D.material.albedo_color.r = 255
	else:
		Sfx.play_pop()
		queue_free()
		
