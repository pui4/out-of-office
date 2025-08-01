extends Node3D

@onready var target : Marker3D = $"cutscene props/SubViewportContainer/SubViewport/Camera3D/PlayerTarget"
@onready var view : SubViewportContainer = $"cutscene props/SubViewportContainer"

func _ready() -> void:
	Lib.current_room = self
	
	view.stretch_shrink = Lib.get_display_dense()
	
	get_tree().root.size_changed.connect(_on_resize)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var player_inst : CharacterBody3D = Lib.player_scene.instantiate()
	get_tree().root.add_child(player_inst)
	player_inst.global_transform = target.global_transform

func _on_resize() -> void:
	view.stretch_shrink = Lib.get_display_dense()
