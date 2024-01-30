extends State

class_name GroundState

@export var jump_velocity : float = -300.0
@export var air_state : State
@export var jump_animation : String = "jump"
@export var jump_finish : bool = true

func process(delta):
	if(!player.is_on_floor()):
		next_state = air_state
		
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump_finish = false
		playback.travel(jump_animation)
		await get_tree().create_timer(0.1).timeout
		player.velocity.y = jump_velocity
		next_state = air_state
		
