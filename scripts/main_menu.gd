extends Node3D

@onready var intro_scene := preload("res://rooms/intro.tscn")
@onready var settings_scene := preload("res://assets/settings_menu.tscn")

func _on_button_pressed() -> void:
	var intro_inst := intro_scene.instantiate()
	get_tree().root.add_child(intro_inst)
	queue_free()

func _on_button_2_pressed() -> void:
	var settings_inst := settings_scene.instantiate()
	add_child(settings_inst)
