extends Node

@onready var main = $"."
@onready var spawnarea = $"spawning range/CollisionShape2D"
@onready var enemy_car = preload("res://scenes/enemy_car.tscn")


var length
var enenmy_count = 0
var enemy_removed = 0

var removable_enemy = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	length = spawnarea.shape.size.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemySpawn()
	enemyRemove()
	enenmy_count = enenmy_count
	print(enenmy_count)
	pass
	
#gets a random position in between the length and spawns the enemy car node.
func enemySpawn():
	if 0 <= enenmy_count && enenmy_count < 4:
		var spawnLocoX = randf_range(0, length)
		var spawnLocoY = spawnarea.position.y
		var enemy = enemy_car.instantiate()
		enemy.position = Vector2(spawnLocoX, spawnLocoY)
		add_child(enemy)
		enenmy_count += 1
		

#gets rid of enemy car when more then 4 co exist
func enemyRemove():
	if removable_enemy.size() > 0:
		var enemy = removable_enemy.pop_back()
		if is_instance_valid(enemy):
			enemy.queue_free()
		enenmy_count -= 1





func _on_exit_range_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("enemy_car"):
		removable_enemy.append(body)
		print(removable_enemy)
		print("deleted")
	pass # Replace with function body.
