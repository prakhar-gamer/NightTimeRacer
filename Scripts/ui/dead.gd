extends Node2D

@onready var PointLabel = $RichTextLabel
@onready var main = $"."

func _ready() -> void:
	main.hide()
	EventManager.Crashed.connect(startUp)
	pass


#Start Up - unhides gui, emits pause signal, sets the point text
func startUp():
	main.show()
	var points = EventManager.Points
	PointLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	PointLabel.text = "you got " + str(points) + " cut ups"
	PointLabel.add_theme_font_size_override("normal_font_size", 25)
	if EventManager.Points > EventManager.BestRun:
		EventManager.BestRun = EventManager.Points

#restart button - sends the signal to restart the game, and hides the menu again
func _on_restart_pressed() -> void:
	EventManager.emit_signal("Restart")
	EventManager.Points = 0
	print(EventManager.BestRun)

#quit button - switches to home screen
func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
	pass
