extends Control

@onready var level = $"../../"
var main_menu : String = "res://ui/MainMenu/main_menu.tscn"

func _on_resume_pressed():
	level.pause_game()
	


func _on_save_game_pressed():
	pass # Replace with function body.


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	SceneTransition.change_scene(main_menu)
