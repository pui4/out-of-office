extends CharacterBody3D

# felix for you own sake i hope you never have to touch this code.

@export var forward_speed : float = 1
@export var side_speed : float = 1
@export var max_speed : float = 20
@export var max_accel : float = 20
@export var friction : float = 1.1
@export var max_lean_deg : float = 7
@export var lean_div : float = -4

@export var lookspeed : float = 0.1

@onready var head : Node3D = $"SubViewportContainer/SubViewport/head"
@onready var camera : Camera3D = $"SubViewportContainer/SubViewport/head/Camera3D"
@onready var arm_cam : Camera3D = $"SubViewportContainer/SubViewport2/Camera3D2"

@onready var target_head : Marker3D = $"target_head"
@onready var target_camera : Marker3D = $"target_head/target_camera"

@onready var arm_anim : AnimationPlayer = $"SubViewportContainer/SubViewport/head/Camera3D/arms/player/AnimationPlayer"

@onready var footsteps_sfx : RandomSound = $"FootstepSFX"

@onready var raycast : RayCast3D = $"SubViewportContainer/SubViewport/head/Camera3D/RayCast3D"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Lib.player = self
	max_accel *= max_speed
	
	arm_anim.speed_scale = 1.5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * lookspeed))
			target_head.rotate_x(deg_to_rad(-event.relative.y * lookspeed))
			target_head.rotation.x = clamp(target_head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	elif event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	# Setting cameras
	head.global_transform = target_head.global_transform
	camera.global_transform = target_camera.global_transform
	arm_cam.global_transform = target_camera.global_transform
	
	# Movement
	var wishdir = Vector3(Input.get_axis("left", "right") * side_speed, 0, Input.get_axis("forward", "backward") * forward_speed).normalized()
	wishdir = wishdir.rotated(Vector3.UP, target_head.global_rotation.y)
		
	var current_speed = velocity.dot(wishdir)
	var add_speed = clamp(max_speed - current_speed, 0, max_accel * delta)
	velocity = velocity + add_speed * wishdir
	
	# holy magic number
	camera.fov = remap(velocity.length(), 0, max_speed, 70, 100)
	camera.fov = clamp(camera.fov, 70, 100)
	arm_cam.fov = camera.fov
	
	var target_lean_rot = velocity.rotated(Vector3.UP, -target_camera.global_rotation.y).x / lean_div
	target_lean_rot = clamp(target_lean_rot, -max_lean_deg, max_lean_deg)
	target_camera.rotation.z = deg_to_rad(target_lean_rot)
	
	velocity /= friction
	
	move_and_slide()
	
	# Arm animation
	if wishdir != Vector3.ZERO and not arm_anim.is_playing():
		arm_anim.play("running")
	elif wishdir == Vector3.ZERO:
		arm_anim.pause()
	
	# Footsteps
	if wishdir != Vector3.ZERO and not footsteps_sfx.is_random_playing:
		footsteps_sfx.loop = true
		footsteps_sfx.play_random()
	elif wishdir == Vector3.ZERO:
		footsteps_sfx.loop = false
		footsteps_sfx.stop_random()
		
	# Check for interactions
	if Input.is_action_just_pressed("interact") and raycast.is_colliding():
		var hit : Node3D = raycast.get_collider()
		if hit.is_in_group("task"):
			Lib.task_interaction.emit(hit)
