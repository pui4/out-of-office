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
var post_inst : CanvasLayer

@onready var death_screen : PackedScene = preload("res://death.tscn")

var died_to : String
var death_inst : Control

@onready var music : AudioStreamMP3 = preload("res://sfx/music.mp3")
var audio_node : AudioStreamPlayer

@onready var player_scene : PackedScene = preload("res://assets/player.tscn")

func _ready() -> void:
	time = Timer.new()
	add_child(time)
	time.wait_time = base_time
	
	enter_new_room.connect(_on_enter_new_room)
	
	post_inst = postprocess.instantiate()
	add_child(post_inst)
	time.timeout.connect(_on_timeout)
	
	audio_node = AudioStreamPlayer.new()
	add_child(audio_node)

func start_run() -> void:
	time.start()
	run_start.emit()
	
	music.loop = true
	audio_node.stream = music
	audio_node.play()

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
		#chance_spawn = 2
		var chance : int = randi_range(0, chance_spawn - 1)
		if chance == 0: # get his ass in
			get_tree().call_group("light", "flicker")
			var guard_inst : PathFollow3D = guard.instantiate()
			
			get_tree().root.add_child(guard_inst)
			guard_inst.global_position = guard_spawn_dist * -current_room.transform.basis.x
	else:
		get_tree().get_nodes_in_group("guard")[0].queue_free()

func kill(name : String):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	died_to = name
	current_room.queue_free()
	post_inst.queue_free()
	audio_node.queue_free()
	
	death_inst = death_screen.instantiate()
	get_tree().root.add_child(death_inst)

func _on_timeout() -> void:
	kill("timeout")

func reset() -> void:
	# Reset old variables
	door_count = 0
	time.stop()
	time.wait_time = base_time
	death_inst.queue_free()
	
	# Load back in starting things
	post_inst = postprocess.instantiate()
	add_child(post_inst)
	audio_node = AudioStreamPlayer.new()
	add_child(audio_node)
	player = Lib.player_scene.instantiate()
	get_tree().root.add_child(player)
	player.global_position.y = 2.777
	player.global_rotation_degrees.y = -90
	
	# Load start room
	var start_room : PackedScene = load("res://start_room.tscn")
	var start_room_inst : Node3D = start_room.instantiate()
	get_tree().root.add_child(start_room_inst)
