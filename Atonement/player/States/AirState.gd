extends State

class_name AirState

@export var landing_state : LandingState
@export var air_animation : String
var jump_finish : bool

func process(_delta):
	if(Character.is_on_floor()):
		next_state = landing_state
	
func on_enter():
	playback.travel(air_animation)
	
func on_exit():
	if(next_state == landing_state):
		jump_finish = false

func state_input(event: InputEvent):
	if(event.is_action_released("jump") and not jump_finish and Character.velocity.y < 0):
		Character.velocity.y = Character.velocity.y/1.25
		jump_finish = true
	

