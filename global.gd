extends Node

@export var is_dev = true

var day = 1

enum Dialogue {
	WeirdLittleGirl,
	WeirdGuy,	
}
var dialogues = {
	Dialogue.WeirdLittleGirl: "little_girl_dialogue",
	Dialogue.WeirdGuy: "weird_guy_dialogue"
}

enum Rooms {LivingRoom, Bedroom, Garden, Kitchen}
var scences = {
	Rooms.LivingRoom: preload("res://scenes/rooms/living-room.tscn"),
	Rooms.Bedroom: preload("res://scenes/rooms/bedroom.tscn"),
	Rooms.Garden: preload("res://scenes/rooms/garden.tscn"),
	Rooms.Kitchen: preload("res://scenes/rooms/kitchen.tscn"),
}
var to_path = null

func _ready() -> void:
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.timeline_started.connect(func():
		for c in get_tree().root.get_children():
			if c is Room:
				c.process_mode = Node.PROCESS_MODE_DISABLED
	)
	Dialogic.timeline_ended.connect(func():
		for c in get_tree().root.get_children():
			if c is Room:
				c.process_mode = Node.PROCESS_MODE_INHERIT
	)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("exit") and is_dev:
		get_tree().quit()
