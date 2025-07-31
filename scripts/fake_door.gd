extends Area3D

@onready var subview : SubViewportContainer = $"SubViewportContainer"
@onready var anim : AnimationPlayer = $"AnimationPlayer"
@onready var target_cam : Marker3D = $"Camera3D"
@onready var actual_cam : Camera3D = $"SubViewportContainer/SubViewport/Camera3D2"

func _on_body_entered(body: Node3D) -> void:
	print("Sa")
	if body.name == "Player":
		Lib.player.queue_free()
		subview.show()
		anim.play("kill")
		
func _process(delta: float) -> void:
	actual_cam.global_transform = target_cam.global_transform
