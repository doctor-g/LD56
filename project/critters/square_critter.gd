class_name SquareCritter extends CharacterBody3D

signal captured

@export var speed := 1.5
## Radians per second
@export var max_turn_speed := TAU

var _noise : FastNoiseLite
var _seconds_unbound := 0.0
var _captured := false

var bound := true:
	set(value):
		bound = value
		$Eyes.visible = true
		$CollisionShape3D.disabled = false


func _ready() -> void:
	$Eyes.visible = false
	
	_noise = FastNoiseLite.new()
	_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	_noise.seed = randi()


func _physics_process(delta: float) -> void:
	if not bound:
		_seconds_unbound += delta
		var sample := _noise.get_noise_1d(_seconds_unbound)
		var turn := remap(sample, -1, 1, -PI/2, PI/2)
		rotate(Vector3.UP, turn * delta * max_turn_speed)
		
		velocity = Vector3(speed,0,0).rotated(Vector3.UP, rotation.y)
		move_and_slide()


func capture() -> void:
	# The deferred call here seems to allow for multiple calls to this.
	# The state variable avoids this problem.
	if not _captured:
		$CollisionShape3D.set_deferred("disabled", true)
		_captured = true
		captured.emit()


func damage() -> void:
	print("BLEP")
	queue_free()


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
