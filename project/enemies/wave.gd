extends Node3D

@export var size := 1
@export var space_between := 5

var speed := 3.5
var direction := Vector3(-1,0,0)

@onready var _enemies_remaining := size

func _ready() -> void:
	assert(size > 0)
	var mob_width : float = (size-1) * space_between
	for i in size:
		var enemy := preload("res://enemies/square_enemy.tscn").instantiate()
		add_child(enemy)
		if size > 1:
			enemy.position.x = remap(i, 0, size-1, -mob_width/2, mob_width/2)
		
		enemy.hit_left.connect(func():
			direction = Vector3(1,0,0)
		)
		enemy.hit_right.connect(func():
			direction = Vector3(-1,0,0)
		)
		enemy.destroyed.connect(func():
			_enemies_remaining -= 1
			if _enemies_remaining == 0:
				queue_free()
		)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
