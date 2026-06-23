extends Node2D

var currentRoadActive = false
@onready var infiniteRoad = $"."
var roads = []
var relocateRoad = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in infiniteRoad.get_children():
		if node.is_in_group("Road"):
			roads.append(node)
	print(roads)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	roadCache()
	pass

func roadCache():
	for i in range(roads.size()):
		var road = roads[i]
		if road.get_meta("position") == "bottom" && road.bodyExited == true:
			relocateRoad.append(road)
			road.bodyExited = false
			road.set_meta("position", "top")
			var newBottom = roads[(i+1) % roads.size()]
			newBottom.set_meta("position", "bottom")
			var newMiddle = roads[(i+2) % roads.size()]
			newMiddle.set_meta("position", "middle")
			var newHeight = newMiddle.get_top_position()
			road.position.y = int(newHeight)
			print("updated")
	pass

func roadSort():
	if relocateRoad.size() == 2:
			var road = relocateRoad[2]
			var toproad = relocateRoad[(i+2) % relocateRoad.size()]
			var newHeight = toproad.get_top_height()
		pass
