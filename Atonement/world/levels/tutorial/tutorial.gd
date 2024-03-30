extends Node2D

@onready var player : CharacterBody2D = $Player
@onready var hoobot : CharacterBody2D = $HooBot
@onready var projectileContainer : Node2D = $ProjectileContainer
@onready var consumableContainer : Node2D = $ConsumableContainer
@onready var Camera : Camera2D = $Camera2D
@onready var pause_menu : Control = $CanvasLayer/Pause
var rng = RandomNumberGenerator.new()
var paused : bool = false
@export var level_limits : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	player.laser_shot.connect(_on_player_laser_shot)
	hoobot.xp_generated.connect(_on_hoobot_xp_generated)
	hoobot.creds_generated.connect(_on_hoobot_creds_generated)
	var i=0
	while i < 4:
		Camera.set_limit(i,level_limits[i])
		i+=1

func _process(_delta):
	if Input.is_action_pressed("pause"):
		pause_game()
	
func pause_game():
	if paused:
		pause_menu.hide()
	else:
		pause_menu.show()
	paused = !paused
	get_tree().paused = paused

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	projectileContainer.add_child(laser)
	
func _on_hoobot_xp_generated(xp_scene, location, max_quantity):
	var quantity = rng.randi_range(2, max_quantity)
	for i in quantity:
		i = i*2*pow(-1, i)
		var xp = xp_scene.instantiate()
		xp.global_position = Vector2(location.x+i, location.y+i)
		consumableContainer.add_child(xp)
		
func _on_hoobot_creds_generated(xp_scene, location, max_quantity):
	for i in max_quantity:
		var quantity = rng.randi_range(0, i)
		for j in quantity:
			var xp = xp_scene.instantiate()
			j = j*5*pow(-1, j)
			print_debug(j)
			xp.global_position = Vector2(location.x+j, location.y-j-i)
			consumableContainer.add_child(xp)

