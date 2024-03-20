extends State

class_name AttackState

@export var return_state : State
@export var attack_animation : String
@export var moving_attack_animation : String

var attack_actions : Array = ["shoot_right", "shoot_left", "shoot_up", "shoot_down"]

var attack_finish : bool = false
@onready var timer : Timer = $Timer


func on_enter():
	attack_finish = false
	timer.start()

func state_input(event : InputEvent):
	for attack in attack_actions:
		if event.is_action_released(attack):
			timer.stop()
			next_state = return_state
			if Character.crouching:
				playback.travel("crouch")
			else:
				playback.travel("move")
	if event.is_action_pressed("crouch"):
		Character.crouch()
	if event.is_action_released("crouch"):
		Character.stand()
		
	
func process(delta):
	if Character.crouching:
		playback.travel("Crouching attack")
	elif Character.velocity.x == 0:
		Character.stand()
		playback.travel(attack_animation)
	else:
		Character.move()
		playback.travel(moving_attack_animation)

func _on_timer_timeout():
	Character.shoot()
	
