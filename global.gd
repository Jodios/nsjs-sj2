extends Node

@export var is_dev = true

var day = 1

enum Rooms {LivingRoom, Bedroom, Garden, Kitchen}
var scences = {
	Rooms.LivingRoom: preload("res://scenes/rooms/living-room.tscn"),
	Rooms.Bedroom: preload("res://scenes/rooms/bedroom.tscn"),
	Rooms.Garden: preload("res://scenes/rooms/garden.tscn"),
	Rooms.Kitchen: preload("res://scenes/rooms/kitchen.tscn"),
}
var to_path = null

func _input(event: InputEvent) -> void:
	if event.is_action_released("exit") and is_dev:
		get_tree().quit()
