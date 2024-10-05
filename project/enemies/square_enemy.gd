extends CharacterBody3D

func damage() -> void:
	for critter in $Critters.get_children():
		critter.bound = false
		critter.reparent(get_parent())
	queue_free()
