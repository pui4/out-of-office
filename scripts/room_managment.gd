extends Node3D

@onready var real_door : PackedScene = preload("res://assets/door.tscn")
@onready var fake_door : PackedScene = preload("res://assets/fake_door.tscn")

func _ready() -> void:
	var markers : Array[Node] = get_tree().get_nodes_in_group("door_marker")
	
	var target_real : int = randi_range(0, len(markers) - 1)
	var rdoor_inst : Node3D = real_door.instantiate()
	add_child(rdoor_inst)
	rdoor_inst.global_transform = markers[target_real].global_transform
	
	print(target_real)
	print(len(markers) - 1)
	print(len(markers))
	markers.remove_at(target_real)
	print(len(markers))
	for marker in markers:
		var fdoor_inst : Node3D = fake_door.instantiate()
		add_child(fdoor_inst)
		fdoor_inst.global_transform = marker.global_transform
