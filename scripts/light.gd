extends Node3D

@export var rand_min = 0.9
@export var rand_max = 1.1

@onready var down_light : SpotLight3D = $"SpotLight3D"
@onready var up_light : SpotLight3D = $"SpotLight3D2"
@onready var anim : AnimationPlayer = $"AnimationPlayer"

var target_light_energy : float

func _ready() -> void:
	var colour = Color(up_light.light_color.r * randf_range(rand_min,rand_max), up_light.light_color.g * randf_range(rand_min,rand_max), up_light.light_color.b * randf_range(rand_min,rand_max))
	
	target_light_energy = randf_range(rand_min,rand_max) * 2
	up_light.light_energy = target_light_energy
	
	up_light.light_color = colour
	down_light.light_color = colour

func flicker() -> void:
	anim.speed_scale = randf_range(0.8, 1.2)
	anim.play("flicker")

func stop_flicker() -> void:
	anim.stop()
	anim.play("RESET")

func turn_off() -> void:
	up_light.light_energy = 0
	down_light.light_energy = 0

func turn_on() -> void:
	down_light.light_energy = 1
	up_light.light_energy = target_light_energy
