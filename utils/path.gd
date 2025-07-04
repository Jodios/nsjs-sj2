class_name Path
extends Node2D

@export var path_name: String
@export var to_path_name: String
@export var path_area: Area2D
@export var to: Global.Rooms
@export var spawn_point: ColorRect

func _ready() -> void:
	spawn_point.visible = false
	path_area.body_entered.connect(handle_entry)

func handle_entry(body: Node2D):
	if body is not Player:
		return
	Global.to_path = to_path_name
	get_tree().call_deferred("change_scene_to_packed",Global.scences[to])
