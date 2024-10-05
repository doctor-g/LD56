extends Node3D

const DESCEND_DISTANCE := 2.0

var size := 1
var space_between := 3
var time_between_descents := 3.0
var speed := 3.5

var _direction := Vector3(-1,0,0)

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
			_direction = Vector3(1,0,0)
		)
		enemy.hit_right.connect(func():
			_direction = Vector3(-1,0,0)
		)
		enemy.destroyed.connect(func():
			_enemies_remaining -= 1
			if _enemies_remaining == 0:
				queue_free()
		)
		
	descend()


func descend() -> void:
	await create_tween()\
		.tween_property(self, "position:z", position.z + DESCEND_DISTANCE, 1.0)\
		.finished
	await get_tree().create_timer(time_between_descents).timeout
	descend()
	

func _physics_process(delta: float) -> void:
	position += _direction * speed * delta
