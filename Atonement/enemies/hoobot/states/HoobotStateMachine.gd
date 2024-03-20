extends Node

class_name HooBotStateMachine

@export var hoobot : CharacterBody2D 
@export var current_state : State


var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			child.Character = hoobot
		else:
			push_warning("Child " + child.name + " is not a state for Player")

func _physics_process(delta):
	if(current_state.next_state != null):
		switch_state(current_state.next_state)
	current_state.process(delta)
	
func check_movement():
	return current_state.can_move

func switch_state(new_state : State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
		
	current_state = new_state
	
	current_state.on_enter()
	
