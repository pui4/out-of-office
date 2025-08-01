extends Node3D

@onready var player : PackedScene = preload("res://assets/player.tscn")
@onready var target : Marker3D = $"cutscene props/SubViewportContainer/SubViewport/Camera3D/PlayerTarget"

func _ready() -> void:
	Lib.current_room = self

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var player_inst : CharacterBody3D = player.instantiate()
	get_tree().root.add_child(player_inst)
	player_inst.global_transform = target.global_transform
