extends State

class_name GroundState

@export var air_state : State
@export var jump_start_state : State

@export var attack_state : State
@export var attack_animation : String
@export var crouch_animation : String
@export var moving_attack_animation : String 
var attack_actions : Array = ["shoot_right", "shoot_left", "shoot_up", "shoot_down"]
var uncrouched : bool = true


func process(_delta):
	if(!Character.is_on_floor()):
		next_state = air_state
	if Character.velocity.x != 0:
		Character.move()
	elif uncrouched:
		Character.stand()

func on_enter():
	if Character.crouching:
		playback.travel("Crouching")
		uncrouched = false
	else:
		playback.travel("move")
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		Character.stand()
		next_state = jump_start_state
	if event.is_action_pressed("crouch"):
		uncrouched = false
		Character.crouch()
		playback.travel(crouch_animation)
	if event.is_action_released("crouch"):
		uncrouched = true
		playback.travel("move")
	for action in attack_actions:
		if event.is_action(action):
			attack()
		
func attack():
	if Character.velocity.x !=0:
		playback.travel(moving_attack_animation)
	else:
		playback.travel(attack_animation)
	next_state = attack_state
		
