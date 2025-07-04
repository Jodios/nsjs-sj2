extends Node2D

@onready var start_button: Button = $AspectRatioContainer/StartButton

func _ready() -> void:
	start_button.button_up.connect(func():
		get_tree().change_scene_to_packed(Global.scences[Global.Rooms.LivingRoom])
	)
