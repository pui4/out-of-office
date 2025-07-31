class_name RandomSound3D extends AudioStreamPlayer3D

@export var streams : Array[AudioStream]
@export var loop : bool
@export var is_random_playing : bool
@export var time_delay : float
@export var play_on_load : bool

func _ready() -> void:
	finished.connect(_on_finished)
	
	if play_on_load:
		play_random()

func play_random() -> void:
	var target_audio : int = randi() % len(streams) - 1
	stream = streams[target_audio]
	play()
	is_random_playing = true

func stop_random() -> void:
	stop()
	is_random_playing = false

func _on_finished() -> void:
	if loop:
		await get_tree().create_timer(time_delay).timeout
		play_random()
	else:
		is_random_playing = false
