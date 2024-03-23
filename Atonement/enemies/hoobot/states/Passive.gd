extends State

var rng = RandomNumberGenerator.new()
var counter : int
var stopped : bool = true
@onready var direction_timer : Timer = $DirectionTimer
@export var aggressive_state : State
@export_range(-20, -3, 1) var erratic_factor : float = -10
@export_range(20, 3, 1) var decisive_factor : float = 10
func on_enter():
	direction_timer.start()
	
func on_exit():
	direction_timer.stop()
	
func process(delta):
	if Character.health < Character.full_health:
		next_state=aggressive_state


func _on_direction_timer_timeout():
	counter+=1
	var new_direction = rng.randi_range(erratic_factor, decisive_factor-counter)
	print_debug(new_direction)
	if new_direction<-3:
		Character.direction.x = -Character.direction.x
		counter = 0
	elif new_direction<3:
		Character.direction.x = 0
		counter = 0
		stopped = true
	elif stopped:
		Character.direction.x = rng.randi_range(0, 1)*2-1
		stopped = false
			
	
