extends State

class_name AirState

@export var landing_state : LandingState
@export var landing_animation : String = "landing"
@export var jump_finish : bool

func process(delta):
	if(player.is_on_floor()):
		next_state = landing_state
	
	
func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)
		jump_finish = false

func state_input(event: InputEvent):
	if(!event.is_action_pressed("jump") and not jump_finish and player.velocity.y < 0):
		player.velocity.y = player.velocity.y/2
		jump_finish = true

