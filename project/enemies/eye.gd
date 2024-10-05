@tool
extends Node2D

@export var radius := 10.0

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color.WHITE_SMOKE)
	draw_circle(Vector2(radius / 2, 0), radius / 4, Color.DARK_BLUE)
