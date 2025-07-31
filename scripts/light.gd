extends Node3D
@export var rand_min = 0.9
@export var rand_max = 1.1
func _ready() -> void:
	
	
	
	var light = $SpotLight3D
	
	var colour = Color(light.light_color.r * randf_range(rand_min,rand_max), light.light_color.g * randf_range(rand_min,rand_max), light.light_color.b * randf_range(rand_min,rand_max))
	
	$SpotLight3D.light_energy *= randf_range(rand_min,rand_max)
	
	$SpotLight3D.light_color = colour
	$SpotLight3D2.light_color = colour
