extends State

class_name CrouchState

@export var ground_state : State
@export var air_state : State

@export var crouch_attack_state : State
var attack_actions : Array = ["shoot_right", "shoot_left", "shoot_up", "shoot_down"]

func on_enter():
	playback.travel("crouch")
	Character.crouch()

func process(_delta):
	if(!Character.is_on_floor()):
		next_state = air_state

func state_input(event):
	if event.is_action_released("crouch"):
		Character.stand()
		next_state=ground_state
	for attackInput in attack_actions:
		if event.is_action_pressed(attackInput):
			next_state = crouch_attack_state
