extends Node2D

@onready var start_button_area: Area2D = $PlayArea
@onready var exit_button_area: Area2D = $QuitArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var play_button_hovered = false
var exit_button_hovered = false

func _ready() -> void:
	#Transitions.fade_into(Global.Rooms.Bedroom)
	#return
	start_button_area.mouse_entered.connect(func():
		animation_player.play("hover_play")
		play_button_hovered = true
	)
	exit_button_area.mouse_entered.connect(func():
		animation_player.play("hover_exit")
		exit_button_hovered = true
	)
	start_button_area.mouse_exited.connect(func():
		animation_player.play_backwards("hover_play")
		play_button_hovered = false
	)
	exit_button_area.mouse_exited.connect(func():
		animation_player.play_backwards("hover_exit")
		exit_button_hovered = false
	)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("exit"):
		get_tree().quit()
	if event.is_action_released("start"):
		start_game()
	if event is InputEventMouseButton and event.is_released() and (event as InputEventMouseButton).button_index == 1:
		if play_button_hovered:
			start_game()
		if exit_button_hovered:
			get_tree().quit()

func start_game() -> void:
	Dialogic.start(Global.dialogues[Global.Dialogue.Intro])
	Transitions.fade_into(Global.Rooms.Bedroom)
	return
	var text = "Day " + str(Global.day) + "..."
	Transitions.timed_fade_into_with_text(
		text, 2, 2,
		Global.Rooms.Bedroom
	)
