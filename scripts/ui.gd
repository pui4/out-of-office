extends Control

@onready var time_txt : RichTextLabel = $"TimeText"
@onready var plus_txt : RichTextLabel = $"TimeText/PlusTime"
@onready var anim : AnimationPlayer = $"AnimationPlayer"

func _ready() -> void:
	Lib.time_increased.connect(_on_increase_time)

func _process(delta: float) -> void:
	var mins : int = floor(Lib.time.time_left / 60)
	var secs : int = Lib.time.time_left - mins * 60
	
	time_txt.text = "[wave][center]TIME: %s:%s" % [mins, "%0*d" % [2, secs]]

func _on_increase_time(secs : float) -> void:
	anim.stop()
	var mins : int = floor(secs / 60)
	var new_secs : int = secs - mins * 60
	plus_txt.text = "+%s:%s" % [mins, "%0*d" % [2, new_secs]]
	anim.play("popup_time")
