extends Control

func _ready() -> void:
	if OS.has_feature("editor"):
		await get_tree().process_frame
		_start_game()


func _start_game() -> void:
	get_tree().change_scene_to_packed(preload("res://world/world.tscn"))


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_start_game()
