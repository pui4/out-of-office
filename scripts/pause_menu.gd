extends CanvasLayer

@onready var settings := preload("res://assets/settings_menu.tscn")

var settings_inst : CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if not visible:
			show()
			
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			resume()

func resume() -> void:
	hide()
	
	if is_instance_valid(settings_inst):
		settings_inst.queue_free()
	
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_button_2_pressed() -> void:
	settings_inst = settings.instantiate()
	add_child(settings_inst)

func _on_button_3_pressed() -> void:
	var menu_scene : PackedScene = load("res://main_menu.tscn")
	var menu_inst := menu_scene.instantiate()
	get_tree().root.add_child(menu_inst)
	
	Lib.player.queue_free()
	Lib.current_room.queue_free()
	Lib.time.stop()
	Lib.time.wait_time = Lib.base_time
	Lib.audio_node.stop()
	Lib.audio_node.stream = Lib.base_ambiance
	Lib.audio_node.play()
	Lib.door_count = 0
	for guard in get_tree().get_nodes_in_group("guard"):
		guard.queue_free()
	queue_free()
	get_tree().paused = false
