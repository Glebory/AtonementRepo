extends State

class_name AttackState

@export var ground_state : State
@export var attack_animation : String
@export var crouch_attack_state : State
@export var moving_attack_animation : String

var attack_actions : Array = ["shoot_right", "shoot_left", "shoot_up", "shoot_down"]

@onready var timer : Timer = $'../FireRate'


func on_enter():
	playback.travel("attack")
	timer.start()

func state_input(event : InputEvent):
	for attack in attack_actions:
		if event.is_action_released(attack):
			timer.stop()
			next_state = ground_state
	if event.is_action_pressed("crouch"):
		Character.crouch()
		next_state = crouch_attack_state

func _on_timer_timeout():
	Character.shoot()
	
