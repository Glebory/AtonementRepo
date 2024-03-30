extends "res://ConsumablesAndItems/consumable.gd"

@onready var light : PointLight2D = $PointLight2D
@export_range(0,3) var index : int
var possible_value : Array = [5, 10, 25, 50]
var value : int = possible_value[index]
#var cred_image = Image.load_from_file("res://ConsumablesAndItems/creds/creds.png")
#var cred_sprite : ImageTexture = ImageTexture.create_from_image((cred_image))


func _ready():
	#sprite.texture = cred_sprite
	sprite.set_frame(index)
	light.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_absorber_body_entered(body):
	if body.is_in_group("player"):
		body.cred_up(value)
		queue_free()
