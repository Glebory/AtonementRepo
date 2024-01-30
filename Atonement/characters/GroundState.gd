extends State

class_name GroundState

@export var air_state : State
@export var jump_start_state : State
@export var jump_animation : String = "jump"

func process(delta):
	if(!player.is_on_floor()):
		next_state = air_state
		
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		playback.travel(jump_animation)
		next_state = jump_start_state
		
