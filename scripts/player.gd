extends CharacterBody3D

@export var forward_speed : float = 1
@export var side_speed : float = 1
@export var max_speed : float = 20
@export var max_accel : float = 20
@export var friction : float = 1.1
@export var max_lean_deg : float = 7
@export var lean_div : float = 2.5

@export var lookspeed : float = 0.1

@onready var head : Node3D = $"head"
@onready var camera : Camera3D = $"head/Camera3D"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	max_accel *= max_speed

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * lookspeed))
			head.rotate_x(deg_to_rad(-event.relative.y * lookspeed))
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	elif event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	# Movement
	var wishdir = Vector3(Input.get_axis("left", "right") * side_speed, 0, Input.get_axis("forward", "backward") * forward_speed).normalized()
	wishdir = wishdir.rotated(Vector3.UP, head.global_rotation.y)
	
		
	var current_speed = velocity.dot(wishdir)
	var add_speed = clamp(max_speed - current_speed, 0, max_accel * delta)
	velocity = velocity + add_speed * wishdir
	
	# holy magic number
	camera.fov = remap(velocity.length(), 0, max_speed, 70, 100)
	camera.fov = clamp(camera.fov, 70, 100)
	print(current_speed)
	
	var target_lean_rot = velocity.rotated(Vector3.UP, -camera.global_rotation.y).x / lean_div
	target_lean_rot = clamp(target_lean_rot, -max_lean_deg, max_lean_deg)
	camera.rotation.z = deg_to_rad(target_lean_rot)
	
	velocity /= friction
	
	move_and_slide()
