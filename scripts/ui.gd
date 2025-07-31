extends Control

@onready var time_txt : RichTextLabel = $"TimeText"

func _process(delta: float) -> void:
	var mins : int = floor(Lib.time.time_left / 60)
	var secs : int = Lib.time.time_left - mins * 60
	
	time_txt.text = "[wave][center]TIME: %s:%s" % [mins, secs]
