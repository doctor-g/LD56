extends CharacterBody2D

signal damaged

var bound_as_enemy := true

var speed := 50.0

func damage() -> void:
	damaged.emit()


func _physics_process(_delta: float) -> void:
	if not bound_as_enemy:
		move_and_slide()
