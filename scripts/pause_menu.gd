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
