extends PathFollow3D

@export var chase_speed : float = 3
@export var track_range : float = 10

func _process(delta: float) -> void:
	if global_position.distance_to(Lib.current_room.global_position) <= 10:
		global_transform = Lib.room_track.global_transform
	else:
		global_position = global_position.lerp(Lib.current_room.global_position, chase_speed * delta)
