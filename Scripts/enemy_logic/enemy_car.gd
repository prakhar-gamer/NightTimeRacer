extends CharacterBody2D


@export var SPEED = 300.0
@export var acceleration = 100
var MaxVelocity = 500
const JUMP_VELOCITY = -400.0

@export var direction = "up"

func _ready() -> void:
	add_to_group("enemy_car")
	pass

func _physics_process(delta: float) -> void:
	#adds the force for forward and back motion
	#engine force
	velocity.y += acceleration * delta
	velocity.y = clampf(velocity.y, 0, MaxVelocity)
	move_and_slide()
	pass


#makes the car automatically go a direction
func travel():
	pass


func _on_crash_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_car"):
		print("Crashed!")
	pass # Replace with function body.
