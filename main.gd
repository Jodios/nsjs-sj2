extends Node2D

@onready var start_button: Button = $AspectRatioContainer/StartButton

func _ready() -> void:
	start_button.button_up.connect(start_game)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("start"): start_game()

func start_game() -> void:
	Transitions.fade_into(Global.Rooms.Bedroom)
	return
	var text = "Day " + str(Global.day) + "..."
	Transitions.timed_fade_into_with_text(
		text, 2, 2,
		Global.Rooms.Bedroom
	)
