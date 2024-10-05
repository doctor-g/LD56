extends Node2D

func _ready() -> void:
	for child in get_children():
		child.damaged.connect(_on_component_damaged)


func _on_component_damaged() -> void:
	for child in get_children():
		child.damaged.disconnect(_on_component_damaged)
		child.bound_as_enemy = false
		child.velocity = child.position.normalized() * child.speed
