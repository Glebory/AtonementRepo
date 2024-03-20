extends Node2D

@onready var player : CharacterBody2D = $Player
@onready var projectileContainer : Node2D = $ProjectileContainer
@onready var Camera : Camera2D = $Camera2D

@export var level_limits : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	player.laser_shot.connect(_on_player_laser_shot)
	var i=0
	while i < 4:
		Camera.set_limit(i,level_limits[i])
		i+=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	projectileContainer.add_child(laser)
