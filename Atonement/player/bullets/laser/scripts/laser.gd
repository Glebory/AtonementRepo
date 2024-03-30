extends Area2D

@export var speed : int = 100
@export var lifetime : int = 0
@export var lifeEnd : int = 1500
@export var knockback : int = 50
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite : Sprite2D = $Sprite2D
var direction
var dmg : int = 20

func _ready():
	direction = global_position.direction_to(player.global_position)
	if direction.x < 0:
		sprite.flip_h = false
	elif direction.x > 0:
		sprite.flip_h = true
	knockback = -knockback*direction.x

func _physics_process(delta):
	global_position.x += -1*direction.x*speed*delta
	lifetime += speed*delta
	if lifetime > lifeEnd:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("hit"):
		body.hit(dmg, knockback) 
