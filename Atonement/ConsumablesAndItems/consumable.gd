extends RigidBody2D

var rng = RandomNumberGenerator.new()
var speed : int = 20
var velocity : Vector2
var direction : Vector2
@onready var sprite : Sprite2D = $Sprite2D

func _ready():
	direction.x  = rng.randf_range(-2,2)
	direction.y = rng.randf_range(-2,0)
	linear_velocity.x = direction.x * speed * 1.6
	linear_velocity.y = direction.y * speed
	direction.x = 1
	direction.y = 1


func _physics_process(_delta):
	if linear_velocity.x < 0:
		linear_velocity.x += 1
	if linear_velocity.x > 0:
		linear_velocity.x -= 1
	apply_force(velocity)

func _on_player_checker_body_entered(body):
	if body.is_in_group("player"):
		direction = global_position.direction_to(body.global_position)
		velocity = speed*direction*2
		gravity_scale = 0.4


func _on_player_checker_body_exited(body):
	if body.is_in_group("player"):
		velocity /= 2
		gravity_scale = 0.8


func _on_absorber_body_entered(_body):
	pass
