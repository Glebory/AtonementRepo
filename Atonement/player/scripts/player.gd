extends CharacterBody2D

signal laser_shot(laser_scene, location)

@export var speed : float = 150.0
@export var health : int = 200

@onready var gun : Marker2D = $gun
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : PlayerStateMachine = $PlayerStateMachine
@onready var hit_box : CollisionShape2D = $Hitbox
@onready var invincibility_timer : Timer = $Invincibility

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var walk_direction : Vector2 = Vector2.ZERO
var look_direction : Vector2 = Vector2.ZERO
var laser_scene  = preload("res://player/bullets/laser/scenes/laser.tscn")
var standing_hit_box : Shape2D
var crouching_hit_box : Shape2D
var walking_hit_box : Shape2D
var crouching : bool = false
var moving : bool = false
var invincibility : bool = false
var invincibility_counter : int

func _ready():
	animation_tree.active = true
	crouching_hit_box = CapsuleShape2D.new()
	standing_hit_box = CapsuleShape2D.new()
	walking_hit_box = CapsuleShape2D.new()
	walking_hit_box.height = 48
	walking_hit_box.radius = 4
	standing_hit_box.height = 48
	standing_hit_box.radius = 7
	crouching_hit_box.height = 31
	crouching_hit_box.radius = 7

	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	walk_direction = Input.get_vector("walk left", "walk right", "look up","crouch")
	look_direction = Input.get_vector("shoot_left", "shoot_right", "shoot_up","shoot_down")
	if walk_direction.x !=0 && state_machine.check_movement():
		velocity.x = walk_direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	invincibilityFrames(delta)
	move_and_slide()
	animation_update()
	
	
func animation_update():
	animation_tree.set("parameters/move/blend_position", walk_direction.x)
	animation_tree.set("parameters/attack move/TimeScale/scale", 1)
	if look_direction.x > 0:
		sprite.flip_h = false
		gun.position.x = abs(gun.position.x)
		if walk_direction.x < 0:
			animation_tree.set("parameters/attack move/TimeScale/scale", -1)
	elif look_direction.x < 0:
		sprite.flip_h = true
		gun.position.x = abs(gun.position.x)*-1
		if walk_direction.x > 0:
			animation_tree.set("parameters/attack move/TimeScale/scale", -1)
	else:
		if walk_direction.x > 0:
			sprite.flip_h = false
		elif walk_direction.x < 0:
			sprite.flip_h = true

func shoot():
	laser_shot.emit(laser_scene, gun.global_position)
	
func crouch():
	if not crouching:
		hit_box.set_shape(crouching_hit_box)
		hit_box.position.y = 8
		crouching = true
		gun.position.x = 17
		gun.position.y = 0
	
func stand():
	if crouching or moving:
		hit_box.set_shape(standing_hit_box)
		hit_box.position.y = 0
		crouching = false
		moving = false
		gun.position.x = 28
		gun.position.y = -17

func move():
	if not crouching and not moving:
		gun.position.x = 21
		gun.position.y = -16
		hit_box.set_shape(walking_hit_box)
		moving = true
		
func hit(dmg):
	self.set_collision_layer_value(3, false)
	health -= dmg
	invincibility = true
	invincibility_timer.start()
	print_debug(health)

func _on_invincibility_timeout():
	self.set_collision_layer_value(3, true)
	invincibility = false
	sprite.visible = true
	
func invincibilityFrames(delta):
	if invincibility:
		var time_left : int = invincibility_timer.time_left * 100
		if time_left%10 == 0:
			sprite.visible = !sprite.visible 
		
