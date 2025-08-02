extends CanvasLayer

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
	
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
