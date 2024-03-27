extends CharacterBody2D


@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var dmgtmr : Timer = $DamagedTimer

var speed : float = 50.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var dmg : int = 10
var dmging_body : CharacterBody2D
var entered : bool = false
@export var health = 100
@export var full_health = 100

func _physics_process(delta):
	if dmgtmr.is_stopped():
		velocity.x = direction.x * speed
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if velocity.x < 1 and velocity.x  > -1:
		sprite.play("idle")
	else:
		sprite.play("move")
	if health < 0:
		queue_free()

	move_and_slide()
	animation_update()

func animation_update():
	if direction.x < 0:
		sprite.flip_h = false
	elif direction.x > 0:
		sprite.flip_h = true
	if is_on_floor():
		self.rotation = get_floor_normal().angle() +deg_to_rad(90)
		
	
@warning_ignore("shadowed_variable")
func hit(dmg, knockback):
	health -= dmg
	dmgtmr.start()
	velocity.x = knockback
	sprite.self_modulate = Color(1,0,0)

func _on_attackbox_body_entered(body):
	if body.has_method("hit"):
		body.hit(dmg) 

func _on_damaged_timer_timeout():
	sprite.self_modulate = Color(1,1,1)
