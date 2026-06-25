extends Node

@export var xLowerLimit = 0
@export var xHigherLimit =0

@onready var main = $"."
@onready var spawnarea = $"spawning range/CollisionShape2D"
@onready var enemy_car = preload("res://scenes/enemy_car.tscn")
@onready var timer = $Timer

var length
var enenmy_count = 0
var enemy_removed = 0

var removable_enemy = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	length = spawnarea.shape.size.x
	timer.start(randf_range(.2, .8))
	xHigherLimit = main.global_position.x + length/2
	xLowerLimit = main.global_position.x - length/2 
	pass # Replace with function body.

#gets a random position in between the length and spawns the enemy car node.
func enemySpawn():
	if 0 <= enenmy_count && enenmy_count < 4:
		var spawn_pos = spawnarea.global_position
		
		var spawnLocoX = randf_range(xLowerLimit, xHigherLimit)
		var spawnLocoY = spawn_pos.y
		var enemy = enemy_car.instantiate()
		enemy.global_position = Vector2(spawnLocoX, spawnLocoY)
		get_tree().current_scene.add_child(enemy)
		enenmy_count += 1
		

#gets rid of enemy car when more then 4 co exist
func enemyRemove():
	if removable_enemy.size() > 0:
		var enemy = removable_enemy.pop_back()
		if is_instance_valid(enemy):
			enemy.queue_free()
		enenmy_count -= 1





func _on_exit_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy_car"):
		removable_enemy.append(body)
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	enemySpawn()
	enemyRemove()
	enenmy_count = enenmy_count
	
	#spawner timing
	var rngSpawnRate = randf_range(.2,.8)
	timer.start(rngSpawnRate)
