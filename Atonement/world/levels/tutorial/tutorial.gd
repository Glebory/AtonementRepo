extends Node2D

@onready var player : CharacterBody2D = $Player
@onready var projectileContainer : Node2D = $ProjectileContainer
@onready var Camera : Camera2D = $Camera2D
@onready var pause_menu : Control = $CanvasLayer/Pause
var paused : bool = false
@export var level_limits : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	player.laser_shot.connect(_on_player_laser_shot)
	var i=0
	while i < 4:
		Camera.set_limit(i,level_limits[i])
		i+=1

func _process(delta):
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
