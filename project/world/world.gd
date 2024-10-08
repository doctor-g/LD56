extends Node3D

var _captured_critters := 0:
	set(value):
		_captured_critters = value
		_update_score_label()


func _ready() -> void:
	if not Jukebox.playing:
		Jukebox.play()
	
	%BeginMissionButton.grab_focus()
	_update_score_label()
	$PlayerShip.exploded.connect(func():
		%GameOverContainer.visible = true
		%PlayAgainButton.grab_focus()
	)


func _on_child_entered_tree(node: Node) -> void:
	if node.has_signal("captured"):
		node.captured.connect(func(): _captured_critters += 1)


func _update_score_label() -> void:
	%ScoreLabel.text = "Critters Saved: %d" % _captured_critters


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://world/world.tscn"))


func _on_begin_mission_button_pressed() -> void:
	%TitleContainer.visible = false
	%WaveGenerator.start()
	
