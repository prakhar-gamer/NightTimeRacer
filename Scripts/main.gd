extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	EventManager.Restart.connect(restart)
	pass # Replace with function body.


# Input Manager - gets the input, sends the signal/function
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		restart()
	#if Input.is_action_just_pressed("pause"):
		#print("did")
		#if EventManager.pauseState == false:
			#pause()
		#elif EventManager.pauseState == true:
			#unPause()
	pass

##Pause - Stops the game
#func pause():
	#EventManager.pauseState = !EventManager.pauseState
	#EventManager.emit_signal("Pause")
	#get_tree().paused = true
#
#
##Unpause - UnStops the Game
#func unPause():
	#EventManager.pauseState = !EventManager.pauseState
	#get_tree().paused = false
	#


func restart():
	EventManager.pauseState = false
	get_tree().paused = false
	get_tree().reload_current_scene()
	pass
