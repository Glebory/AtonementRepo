extends State

class_name JumpStartState

@export var air_state : State
@export var jump_velocity : float = -300.0
@export var jump_start : String
@export var jump_up : String
@export var jump_animation : String = "jump start"
var jump_finish : bool

func on_enter():
	playback.travel(jump_start)
	can_move = false
	jump_finish = false
	jump_velocity = -300

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == jump_start):
		can_move = true
		Character.velocity.y = jump_velocity
		#playback.travel(jump_up)
		next_state = air_state
		

func state_input(event: InputEvent):
	if(event.is_action_released("jump") and not jump_finish and Character.velocity.y == 0):
		jump_velocity = jump_velocity/1.4
		jump_finish = true
