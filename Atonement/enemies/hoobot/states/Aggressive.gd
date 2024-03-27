extends State

class_name aggressive_state

@onready var player = get_tree().get_first_node_in_group("player")

@export var aggro_speed = 100.0

func on_enter():
	Character.speed = aggro_speed

func process(delta):
	Character.direction = Character.global_position.direction_to(player.global_position)
