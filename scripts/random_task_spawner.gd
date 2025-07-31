extends Marker3D

@export var chance_to_spawn : int = 2
@export var tasks : Array[String] = ["printer_task", "whiteboard_task"]

func _ready() -> void:
	var chance : int = randi_range(0, chance_to_spawn - 1)
	if chance == 0:
		var target_task : int = randi_range(0, len(tasks) - 1)
		var task : PackedScene = load("res://assets/tasks/%s.tscn" % tasks[target_task])
		var task_inst : Node3D = task.instantiate()
		add_child(task_inst)
