extends "res://ConsumablesAndItems/consumable.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	var i = rng.randi_range(2,3)
	sprite.set_frame(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_absorber_body_entered(body):
	if body.is_in_group("player"):
		body.xp_up()
		queue_free()
