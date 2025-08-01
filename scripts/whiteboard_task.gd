extends StaticBody3D

@export var imgs : Array[String] = ["lies", "penis", "face", "ben", "mud", "pui", "hide"]

@onready var sprite : Sprite3D = $"Sprite3D"
@onready var anim : AnimationPlayer = $"AnimationPlayer"
@onready var sfx : AudioStreamPlayer3D = $"AudioStreamPlayer3D"

var done : bool

func _ready() -> void:
	var target_tex : int = randi_range(0, len(imgs) - 1)
	
	var tex : Texture2D = load("res://texture/whiteboard_imgs/%s.png" % imgs[target_tex])
	sprite.texture = tex
	
	Lib.task_interaction.connect(_on_interaction)

func _on_interaction(hit : Node3D) -> void:
	if hit == self and not done:
		anim.play("wipe_board")
		sfx.play()
		Lib.increase_time(3)
		done = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	sfx.stop()
