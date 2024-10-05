extends Node3D

var _captured_critters := 0:
	set(value):
		_captured_critters = value
		_update_score_label()


func _ready() -> void:
	_update_score_label()
	$PlayerShip.exploded.connect(func():
		$GameOverContainer.visible = true
	)


func _on_child_entered_tree(node: Node) -> void:
	if node.has_signal("captured"):
		node.captured.connect(func(): _captured_critters += 1)


func _update_score_label() -> void:
	%ScoreLabel.text = "Score: %d" % _captured_critters


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://world/world.tscn"))
