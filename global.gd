extends Node

@export var is_dev = true

func _input(event: InputEvent) -> void:
	if event.is_action_released("exit") and is_dev:
		get_tree().quit()
