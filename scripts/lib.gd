extends Node

@export var current_room : Node3D
@export var player : CharacterBody3D

@export var time : Timer
@export var base_time : float = 120

func _ready() -> void:
	time = Timer.new()
	add_child(time)
	time.wait_time = base_time
	
	time.start() # TODO: Replace this to start when the game loads
