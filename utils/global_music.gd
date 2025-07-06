extends Node2D

@onready var background_music_player: AudioStreamPlayer2D = $BackgroundMusic
@onready var abyss_music_player: AudioStreamPlayer2D = $AbyssBackground

func _ready() -> void:
	background_music_player.stream.loop = true
	background_music_player.finished.connect(func():
		background_music_player.play(0)
	)
	abyss_music_player.finished.connect(func():
		abyss_music_player.play(0)
	)
	play_background_music()

func play_background_music() -> void:
	if background_music_player.playing: return
	abyss_music_player.stop()
	background_music_player.play(0)
func play_background_music_abyss() -> void:
	if abyss_music_player.playing: return
	background_music_player.stop()
	abyss_music_player.play(0)
