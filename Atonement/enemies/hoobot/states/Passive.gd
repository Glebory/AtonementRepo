extends State

@export var aggressive_state : State


func process(delta):
	if Character.health < Character.full_health:
		next_state=aggressive_state

