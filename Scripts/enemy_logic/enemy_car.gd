extends CharacterBody2D


@export var SPEED = 300.0
@export var acceleration = 100
var MaxVelocity = 500

@onready var ViewZone = $ViewZone/CollisionShape2D
var lane_change = false
var lane_change_angle = 20
var lane = "none"


func _ready() -> void:
	add_to_group("enemy_car")
	pass



func drivingLogic(delta: float) -> float:
	if lane == "right":
		rotation = lane_change_angle * delta
	if lane == "left":
		rotation = -lane_change_angle * delta
	return rotation

func _physics_process(delta: float) -> void:
	#adds the force for forward and back motion
	#engine force
	velocity.y += acceleration * delta
	velocity.y = clampf(velocity.y, 0, MaxVelocity)

	#lane change returns lanechange angle, 
	#velocity x = tan(drivingLogic) * velocity . y
	if lane_change == true:
		velocity.x = tan(drivingLogic(delta)) * velocity.y
	if lane_change == false:
		rotation = 0
		velocity.x = 0
	move_and_slide()
	
	
	pass


#makes the car automatically go a direction
func travel():
	pass


func _on_crash_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_car"):
		print("Crashed!")
	pass # Replace with function body.


func _on_view_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_car"):
		var xMiddle = global_position.x
		if body.global_position.x < xMiddle:
			lane = "right"
		if body.global_position.x > xMiddle:
			lane = "left"
		lane_change=true
	pass # Replace with function body.


func _on_view_zone_body_exited(body: Node2D) -> void:
	lane_change=false
	pass # Replace with function body.
