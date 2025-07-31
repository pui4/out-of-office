extends StaticBody3D

@onready var error_sfx : AudioStreamPlayer3D = $"AudioStreamPlayer3D"
@onready var done_sfx : RandomSound3D = $"RandomSound3D"

@onready var red_light : Sprite3D = $"RedLight"
@onready var green_light : Sprite3D = $"GreenLight"

var done : bool

func _ready() -> void:
	Lib.task_interaction.connect(_on_interaction)

func _on_interaction(hit : Node3D) -> void:
	if hit == self and not done:
		error_sfx.stop()
		done_sfx.play_random()
		red_light.hide()
		green_light.show()
		done = true
