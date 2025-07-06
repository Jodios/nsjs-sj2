extends Node2D

@onready var background_music_player: AudioStreamPlayer2D = $BackgroundMusic

func _ready() -> void:
	background_music_player.stream.loop = true
	background_music_player.finished.connect(func():
		background_music_player.play(0)
	)
	play_background_music()

func play_background_music() -> void:
	background_music_player.play(0)
