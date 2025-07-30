extends Area3D

var rooms : Array[String] = ["testing"]

@onready var next_room_point : Marker3D = $"Next_room"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		var target_room : int = randi() % len(rooms) - 1
		var room : PackedScene = load("res://rooms/%s.tscn" % rooms[target_room])
		var room_inst : Node3D = room.instantiate()
		get_tree().current_scene.add_child(room_inst)
		room_inst.global_position = next_room_point.global_position
		room_inst.global_rotation = next_room_point.global_rotation
		
		if Lib.current_room != null:
			Lib.current_room.queue_free()
		
		Lib.current_room = room_inst
		
		queue_free()
