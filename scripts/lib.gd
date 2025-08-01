extends Node

@export var current_room : Node3D
@export var player : CharacterBody3D

@export var time : Timer
@export var base_time : float = 120

@export var room_has_real_door : bool

@export var door_count : int

signal task_interaction
signal time_increased
signal enter_new_room
signal run_start

@onready var guard : PackedScene = preload("res://billboard test.tscn")

var guard_coming : bool
var chance_spawn : int = 5
var guard_spawn_dist : int = 1000
var room_track : Path3D

@onready var postprocess : PackedScene = preload("res://assets/post_process.tscn")

func _ready() -> void:
	time = Timer.new()
	add_child(time)
	time.wait_time = base_time
	
	enter_new_room.connect(_on_enter_new_room)
	
	var post_inst : CanvasLayer = postprocess.instantiate()
	add_child(post_inst)

func start_run() -> void:
	time.start()
	run_start.emit()

func increase_time(secs: float) -> void:
	var old_time : float = time.time_left
	time.stop()
	time.wait_time = old_time + secs
	time.start()
	time_increased.emit(secs)

func _on_enter_new_room(name : String):
	print(door_count)
	if door_count == 0:
		start_run()
	door_count += 1
	if not guard_coming:
		chance_spawn = (100 / door_count) + 2
		var chance : int = randi_range(0, chance_spawn - 1)
		if chance == 0: # get his ass in
			get_tree().call_group("light", "flicker")
			var guard_inst : PathFollow3D = guard.instantiate()
			
			get_tree().root.add_child(guard_inst)
			guard_inst.global_position = guard_spawn_dist * -current_room.transform.basis.x
	else:
		get_tree().get_nodes_in_group("guard")[0].queue_free()
