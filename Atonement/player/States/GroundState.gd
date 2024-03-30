extends State

class_name GroundState

@export var air_state : State
@export var jump_start_state : State

@export var attack_state : State
@export var attack_animation : String
@export var crouch_state : State
@export var crouch_animation : String
@export var moving_attack_animation : String 

var attack_actions : Array = ["shoot_right", "shoot_left", "shoot_up", "shoot_down"]
var uncrouched : bool = true


func process(_delta):
	if(!Character.is_on_floor()):
		next_state = air_state

func on_enter():
	playback.travel("move")
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		next_state = jump_start_state
	if event.is_action_pressed("crouch"):
		next_state = crouch_state
	for action in attack_actions:
		if event.is_action(action):
			attack()
		
func attack():
	next_state = attack_state
		
