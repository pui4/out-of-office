extends Node

@export var current_room : Node3D
@export var player : CharacterBody3D

@export var time : Timer
@export var base_time : float = 120

@export var room_has_real_door : bool

signal task_interaction
signal time_increased

func _ready() -> void:
	time = Timer.new()
	add_child(time)
	time.wait_time = base_time
	
	time.start() # TODO: Replace this to start when the game loads

func increase_time(secs: float) -> void:
	var old_time : float = time.time_left
	time.stop()
	time.wait_time = old_time + secs
	time.start()
	time_increased.emit(secs)
