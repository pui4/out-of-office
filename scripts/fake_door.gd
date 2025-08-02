extends Area3D

@onready var subview : SubViewportContainer = $"SubViewportContainer"
@onready var anim : AnimationPlayer = $"AnimationPlayer"
@onready var sfx : AudioStreamPlayer = $"AudioStreamPlayer"
@onready var target_cam : Marker3D = $"Camera3D"
@onready var actual_cam : Camera3D = $"SubViewportContainer/SubViewport/Camera3D2"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		subview.stretch_shrink = Lib.get_display_dense()
		get_tree().root.size_changed.connect(_on_resize)
		
		get_tree().call_group("pause", "queue_free")
		Lib.player.queue_free()
		subview.show()
		anim.play("kill")
		sfx.play()
		
		await  get_tree().create_timer(1.2).timeout
		Lib.kill("fake_door")
		
func _process(delta: float) -> void:
	actual_cam.global_transform = target_cam.global_transform

func _on_resize() -> void:
	subview.stretch_shrink = Lib.get_display_dense()
