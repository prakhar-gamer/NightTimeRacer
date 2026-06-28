extends Node2D


#Play Button - switches to game
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass # Replace with function body.


#Quit Button - Closes Game
func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
