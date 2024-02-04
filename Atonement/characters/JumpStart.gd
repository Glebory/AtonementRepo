extends State


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_input(event: InputEvent):
	if(event.is_action_released("jump") and not jump_finish and player.velocity.y < 0):
		player.velocity.y = player.velocity.y/2
		jump_finish = true
