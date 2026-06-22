extends CharacterBody2D


@export var MaxVelocity = 1000
@export var acceleration  = 400
@export var turnFactor = 3
@export var driftFactor = 0.4

var movement = Vector2()
var rotationAngle = 0

@onready var car = $"."

#testing
var count = 0

#gamelogic
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	captureMovement()
	
	#adds the force for forward and back motion
	var currentForwardVelocity = velocity.dot(-global_transform.y)
	
	#checks if the movement and direction require a braking force
	var is_braking = (currentForwardVelocity > 10 && movement.y < 0) or (currentForwardVelocity < -10 and movement.y >0)
	
	#engine force
	var engineForce = -global_transform.y * movement.y * acceleration
	
	if is_braking:
		velocity += engineForce * 3 * delta
	else:
		velocity += engineForce * delta
	
	#adds the froce for side to side motion
	rotationAngle = movement.x * turnFactor
	rotation += rotationAngle * delta
	
	#Reduces perpindicular velocity
	#find the velocity values
	var forwardVelocity = -global_transform.y * velocity.dot(-global_transform.y);
	var rightVelocity = global_transform.x * velocity.dot(global_transform.x)
	
	velocity = forwardVelocity + (rightVelocity * driftFactor)
	
	
	velocity.x = clampf(velocity.x, -MaxVelocity, MaxVelocity)
	velocity.y = clampf(velocity.y, -MaxVelocity, MaxVelocity)
	
	move_and_slide()
	pass

func captureMovement():
	movement = Vector2.ZERO
	if Input.is_action_pressed("forward"):
		movement.y = 1
	if Input.is_action_pressed("down"):
		movement.y = -1
	if Input.is_action_pressed("right"):
		movement.x = 1
	if Input.is_action_pressed("left"):
		movement.x = -1
		
