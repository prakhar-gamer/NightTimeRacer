extends Node2D

var isActive = false
var bodyExited = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enter_road_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_car"):
		isActive = true


func _on_exit_road_body_exited(body: Node2D) -> void:
	if body.is_in_group("player_car"):
		bodyExited = true
		isActive = false

func get_top_position() -> float:
	var street = $Streeet
	var half_height = (street.texture.get_height() * street.scale.y) / 2.0
	return street.global_position.y-half_height
