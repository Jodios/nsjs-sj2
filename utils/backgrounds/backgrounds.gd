extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func fade_in_image(name):
	animation_player.play(name)
