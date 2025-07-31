extends Area3D

#var rooms : Array[String] = ["forwards", "left", "loop left", "loop right", "right", "T-left", "t-right", "fake_room_1"]
var rooms : Array[String] = ["fake_room_1"]

var phys_door : PackedScene = preload("res://assets/phys_door.tscn")
@onready var next_room_point : Marker3D = $"Next_room"

func _ready() -> void:
	Lib.room_has_real_door = true

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		var target_room : int = randi_range(0, len(rooms) - 1)
		var room : PackedScene = load("res://rooms/game rooms/%s.tscn" % rooms[target_room])
		var room_inst : Node3D = room.instantiate()
		get_tree().current_scene.add_child(room_inst)
		room_inst.global_position = next_room_point.global_position
		room_inst.global_rotation = next_room_point.global_rotation
		
		if Lib.current_room != null:
			Lib.current_room.queue_free()
		
		Lib.current_room = room_inst
		Lib.room_has_real_door = false
		
		# Spawn and launch door
		var door_inst : RigidBody3D = phys_door.instantiate()
		Lib.current_room.add_child(door_inst)
		door_inst.global_transform = global_transform
		door_inst.angular_damp = 10
		door_inst.apply_impulse(-Lib.player.transform.basis.z * 250 + (Vector3.UP * 30))
		door_inst.apply_torque_impulse(Vector3(randf_range(0, 50), randf_range(-10, 10), randf_range(-50, 50)))
