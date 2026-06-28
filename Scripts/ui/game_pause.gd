extends Node2D

@onready var main = $"."
@onready var gamePausedText = $gui/PausedText

var dead  = false

# First Run - Hide on scene, Set The Text Size
func _ready() -> void:
	EventManager.Pause.connect(pause)
	EventManager.Crashed.connect(crashed)
	main.hide()
	gamePausedText.add_theme_font_size_override("normal_font_size", 35)
	

func _process(delta: float) -> void:
	if dead == false:
		if Input.is_action_just_pressed("pause"):
			pause(true)
	
# pause screen - game pause state, show or hide 
func pause(screen: bool):
	EventManager.pauseState = !EventManager.pauseState
	get_tree().paused = EventManager.pauseState
	if screen == true:
		print("g")
		if EventManager.pauseState:
			main.show()
		else:
			main.hide()
		pass


#continue - hide gui, emit unPause
func _on_continue_pressed() -> void:
	pause(true)
	

func crashed():
	dead = true
	pass


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
	pass # Replace with function body.
