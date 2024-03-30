extends State

class_name CrouchAttackState

@export var attack_state : State
@export var crouch_state : State
var attack_actions : Array = ["shoot_right", "shoot_left", "shoot_up", "shoot_down"]

@onready var timer : Timer = $'../FireRate'


func on_enter():
	playback.travel("crouch attack")
	timer.start()

func state_input(event : InputEvent):
	for attack in attack_actions:
		if event.is_action_released(attack):
			timer.stop()
			next_state = crouch_state
	if event.is_action_released("crouch"):
		Character.stand()
		next_state = attack_state


func _on_fire_rate_timeout():
	Character.shoot()
