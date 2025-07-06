class_name Room
extends Node2D

enum room_name_enum {KITCHEN, BEDROOM, LIVING_ROOM, GARDEN, ABYSS}
@export var room_name: room_name_enum

var player_scene: PackedScene = preload("res://player/player.tscn")
var player: Player

func _ready() -> void:
	GlobalMusic.play_background_music()
	if room_name == room_name_enum.ABYSS:
		if Global.dialogic_started:
			await Dialogic.timeline_ended
		GlobalMusic.play_background_music_abyss()
		Dialogic.start(Global.dialogues[Global.Dialogue.Abyss])
	if Global.day == 2 and room_name == room_name_enum.LIVING_ROOM and !Global.interacted_with_ghost_today:
		Dialogic.start(Global.dialogues[Global.Dialogue.WeirdGuy])
	if Global.day == 3 and room_name == room_name_enum.KITCHEN and !Global.interacted_with_ghost_today:
		Dialogic.start(Global.dialogues[Global.Dialogue.WeirdLittleGirl])
	for child in get_children():
		if child is Player:
			player = child
	if player == null:
		player = player_scene.instantiate()
		player.position.x = -1000
		player.position.y = -1000
		call_deferred("add_child", player)
		
	if Global.to_path != null:
		var path: Path
		for child in get_children():
			if child is Path and (child as Path).path_name == Global.to_path:
				path = child
				
		# if path is null then the game is broken anyway so ignoring null case
		player.global_position = path.spawn_point.global_position
