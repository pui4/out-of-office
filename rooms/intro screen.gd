extends AnimatedSprite3D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("left") and frame > 0:
		frame -= 1
	if Input.is_action_just_pressed("right"):
		frame += 1
