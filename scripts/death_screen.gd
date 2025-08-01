extends Control

@onready var score_txt : RichTextLabel = $"VBoxContainer/RichTextLabel2"
@onready var hint_txt : RichTextLabel = $"VBoxContainer2/RichTextLabel3"
@onready var anim : AnimationPlayer = $"AnimationPlayer"

func _ready() -> void:
	# Setting hint text
	match Lib.died_to:
		"fake_door":
			hint_txt.text = "[center]You entered the managers office. Look out for them. They are different."
		"guard":
			hint_txt.text = "[center]You were grabbed by the guard. Hide next time?"
		"timeout":
			hint_txt.text = "[center]Well done you tried. Maybe try doing more tasks?"
	
	score_txt.text = "[center]SCORE: %s" % Lib.door_count
	anim.play("start")

func _on_button_pressed() -> void:
	print("presseesd")
