extends State

class_name JumpStartState

@export var air_state : State
@export var jump_velocity : float = -300.0
@export var jump_start : String
@export var jump_up : String
var beginning : int
var jump_finish : bool

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == jump_start):
		player.velocity.y = jump_velocity
		playback.travel(jump_up)
		next_state = air_state
		
func on_enter():
	jump_finish = false
	jump_velocity = -300

func state_input(event: InputEvent):
	if(event.is_action_released("jump") and not jump_finish and player.velocity.y == 0):
		jump_velocity = jump_velocity/2
		jump_finish = true
