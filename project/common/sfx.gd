extends Node2D

const POPS := [
	preload("res://common/pop1.wav"),
	preload("res://common/pop2.wav"),
	preload("res://common/pop3.wav"),
	preload("res://common/pop4.wav"),
]

const PICKUPS := [
	preload("res://common/pickup1.wav"),
	preload("res://common/pickup2.wav"),
	preload("res://common/pickup3.wav"),
	preload("res://common/pickup4.wav"),
	preload("res://common/pickup5.wav"),
]

const DEATHS := [
	preload("res://common/death1.wav"),
	preload("res://common/death2.wav"),
	preload("res://common/death3.wav"),
	preload("res://common/death4.wav"),
	preload("res://common/death5.wav"),
	preload("res://common/death6.wav"),
]

const LASERS := [
	preload("res://common/laser.wav"),
]

const ENEMY_LASERS := [
	preload("res://common/enemy_laser.wav"),
]

const BUBBLES := [
	preload("res://common/bubble.wav"),
]

const PLAYER_EXPLOSION := [
	preload("res://common/player_explosion.wav"),
]

const BREAKAPART := [
	preload("res://common/breakapart.wav"),
]

var _players : Array[AudioStreamPlayer] = []

func play_pop() -> void:
	_play_from(POPS)


func play_pickup() -> void:
	_play_from(PICKUPS)


func play_death() -> void:
	_play_from(DEATHS)


func play_laser() -> void:
	_play_from(LASERS)
	
	
func play_enemy_laser() -> void:
	_play_from(ENEMY_LASERS)


func play_bubble() -> void:
	_play_from(BUBBLES)


func play_player_explosion() -> void:
	_play_from(PLAYER_EXPLOSION)


func play_break_apart() -> void:
	_play_from(BREAKAPART)


func _play_from(array : Array) -> void:
	var player : AudioStreamPlayer
	if _players.is_empty():
		player = AudioStreamPlayer.new()
		add_child(player)
	else:
		player = _players.pop_back()
	player.stream = array.pick_random()
	player.pitch_scale = randfn(1.0, 0.05)
	player.play()
	await player.finished
	_players.append(player)
