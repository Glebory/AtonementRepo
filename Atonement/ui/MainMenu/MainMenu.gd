extends Control

@onready var Options : VBoxContainer = $MarginContainer/HBoxContainer/OptionsMenu
@onready var Menu : VBoxContainer = $MarginContainer/HBoxContainer/Menu



func _on_continue_pressed():
	pass # Replace with function body.


func _on_new_game_pressed():
	SceneTransition.change_scene("res://world/levels/tutorial/tutorial.tscn")


func _on_options_pressed():
	Options.show()
	Menu.hide()

func _on_exit_pressed():
	get_tree().quit()


func _on_back_pressed():
	Options.hide()
	Menu.show()
