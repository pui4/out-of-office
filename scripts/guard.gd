extends PathFollow3D

@export var chase_speed : float = 3
@export var track_speed : float = 50
@export var track_range : float = 10

var setup : bool = true

func _ready() -> void:
	$AudioStreamPlayer3D.play(randf_range(0,1))
	Lib.enter_new_room.connect(_on_new_room)

func _process(delta: float) -> void:
	if is_instance_valid(Lib.current_room):
		if global_position.distance_to(Lib.current_room.global_position) <= 10 and setup:
			global_transform = Lib.room_track.global_transform
			reparent(Lib.room_track)
			get_tree().call_group("light", "stop_flicker")
			get_tree().call_group("light", "turn_off")
			
			await get_tree().create_timer(randf_range(0.5, 1))
			setup = false
		elif global_position.distance_to(Lib.current_room.global_position) > 10 and setup:
			global_position = global_position.lerp(Lib.current_room.global_position, chase_speed * delta)
		else:
			progress += track_speed * delta
	else:
		queue_free()
	
	if progress_ratio == 1:
		get_tree().call_group("light", "turn_on")
		Lib.guard_coming = false
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Lib.kill("guard")

func _on_new_room(name : String):
	queue_free()
