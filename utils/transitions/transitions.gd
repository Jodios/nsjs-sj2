extends Control

var transition_cooldown: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var text_label: Label = $Text

func _ready() -> void:
	text_label.visible = false

func fade_into(target_scene: Global.Rooms) -> void:
	get_tree().paused = true
	animation_player.play("fade")
	await animation_player.animation_finished
	get_tree().call_deferred("change_scene_to_packed",Global.scences[target_scene])
	animation_player.play_backwards("fade")
	animation_player.animation_finished.connect(func(_animation_name):
		get_tree().paused = false
	)
	
func timed_fade_into_with_text(
	text: String,
	seconds_in: float,
	seconds_out: float,
	target_scene: Global.Rooms
) -> void:
	text_label.visible = true
	get_tree().paused = true
	text_label.text = text
	var text_size = text_label.get_rect().size
	var screen_size = get_viewport_rect().size
	text_label.position = Vector2(
		(screen_size.x / 2) - (text_size.x / 2),
		(screen_size.y / 2) - (text_size.y / 2),
	)
	animation_player.speed_scale = 0.5 / seconds_in
	animation_player.play("fade")
	await animation_player.animation_finished
	get_tree().call_deferred("change_scene_to_packed",Global.scences[target_scene])
	get_tree().create_timer(seconds_out).timeout.connect(func():
		animation_player.play_backwards("fade")
		animation_player.animation_finished.connect(func(animation_name):
			get_tree().paused = false
			text_label.visible = false
			animation_player.speed_scale = 1
		)
	)
	
