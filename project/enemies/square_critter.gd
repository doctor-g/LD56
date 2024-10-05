extends CharacterBody2D

signal damaged

@export var bound_as_enemy := true
@export var noise : Noise

var speed := 50.0

func _ready() -> void:
	# Set the velocity to an X-forward vector.
	# It won't be used until this becomes unbound.
	velocity = Vector2(speed, 0).rotated(rotation)


func damage() -> void:
	damaged.emit()


func _physics_process(_delta: float) -> void:
	if not bound_as_enemy:
		move_and_slide()
