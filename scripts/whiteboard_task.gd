extends StaticBody3D

@export var imgs : Array[String] = ["stink"]

@onready var sprite : Sprite3D = $"Sprite3D"
@onready var anim : AnimationPlayer = $"AnimationPlayer"

var done : bool

func _ready() -> void:
	var target_tex : int = randi() % len(imgs) - 1
	var tex : Texture2D = load("res://texture/whiteboard_imgs/%s.png" % imgs[target_tex])
	sprite.texture = tex
	
	Lib.task_interaction.connect(_on_interaction)

func _on_interaction(hit : Node3D) -> void:
	if hit == self and not done:
		anim.play("wipe_board")
		done = true
