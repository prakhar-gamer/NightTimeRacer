extends Node2D

var currentRoadActive = false
@onready var infiniteRoad = $"."
var roads = []
var relocateRoad = []


var lastResult

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in infiniteRoad.get_children():
		if node.is_in_group("Road"):
			roads.append(node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	passedRoads()
	roadSort()
	pass

#makes a cache of all the roads 
#done
func passedRoads():
	lastResult = relocateRoad.duplicate()
	for i in range(roads.size()):
		var road = roads[i]
		if road.bodyExited == true:
			if not relocateRoad.has(road):
				relocateRoad.append(road)
		pass
	pass

#need to remove only the bottom from the relocate road and update middle to be new bottom
func roadSort():
	if relocateRoad.size() >= 1:
		var bottomRoad
		var middleRoad
		var topRoad
		for road in roads:
			if road.get_meta("position")=="bottom":
				bottomRoad = road
			if road.get_meta("position")=="middle":
				middleRoad = road
			if road.get_meta("position") == "top":
				topRoad = road
		
		if relocateRoad.has(bottomRoad):
			var newYPos = topRoad.get_top_position()
			bottomRoad.position.y = newYPos
			bottomRoad.bodyExited = false
			bottomRoad.set_meta("position", "top")
			topRoad.set_meta("position", "middle")
			middleRoad.set_meta("position", "bottom")
			relocateRoad.erase(bottomRoad)
			pass



#func roadCache():
	#for i in range(roads.size()):
		#var road = roads[i]
		#if road.get_meta("position") == "bottom" && road.bodyExited == true:
			#relocateRoad.append(road)
			#road.bodyExited = false
			#road.set_meta("position", "top")
			#var newBottom = roads[(i+1) % roads.size()]
			#newBottom.set_meta("position", "bottom")
			#var newMiddle = roads[(i+2) % roads.size()]
			#newMiddle.set_meta("position", "middle")
			#var newHeight = newMiddle.get_top_position()
			#print("updated")
	#pass
