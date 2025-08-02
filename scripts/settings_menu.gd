extends CanvasLayer

@export var audio_bus_name := "Master"
@onready var _bus := AudioServer.get_bus_index(audio_bus_name)

@onready var vol_bar := $"ColorRect/VBoxContainer/HSlider2"
@onready var sens_bar := $"ColorRect/VBoxContainer/MarginContainer/HSlider"

func _ready() -> void:
	vol_bar.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	sens_bar.value = Lib.player_sens

func _on_vol_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_sens_value_changed(value: float) -> void:
	Lib.player_sens = value

func _on_texture_button_pressed() -> void:
	queue_free()
