extends Node3D

@export var eye_closed_material : Material

@onready var _mesh := $detail_eyeLarge

func _ready() -> void:
	var surfaces : int = _mesh.get_surface_override_material_count()
	for i in surfaces:
		_mesh.set_surface_override_material(i, eye_closed_material)


func open() -> void:
	var surfaces : int = _mesh.get_surface_override_material_count()
	for i in surfaces:
		_mesh.set_surface_override_material(i, null)
