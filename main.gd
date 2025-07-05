extends Node2D

@onready var start_button: Button = $AspectRatioContainer/StartButton

func _ready() -> void:
	start_button.button_up.connect(func():
		var text = "Day " + str(Global.day) + "..."
		Transitions.timed_fade_into_with_text(
			text, 2, 2,
			Global.Rooms.LivingRoom
		)
	)
