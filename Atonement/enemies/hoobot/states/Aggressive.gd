extends State

class_name aggressive_state

@onready var player = get_node("/root/Node2D/Player")

@export var aggro_speed = 100.0

func on_enter():
	Character.speed = aggro_speed

func process(delta):
	Character.direction = Character.global_position.direction_to(player.global_position)