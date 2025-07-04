class_name Room
extends Node2D

var player_scene: PackedScene = preload("res://player/player.tscn")
var player: Player

func _ready() -> void:
	for child in get_children():
		if child is Player:
			player = child
	if player == null:
		player = player_scene.instantiate()
		get_tree().root.call_deferred("add_child", player)
		
	if Global.to_path != null:
		var path: Path
		for child in get_children():
			if child is Path and (child as Path).path_name == Global.to_path:
				path = child
				
		# if path is null then the game is broken anyway so ignoring null case
		player.position = path.spawn_point.global_position
