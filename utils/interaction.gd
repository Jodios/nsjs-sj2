extends Area2D

@onready var interaction_icon: Sprite2D = $InteractIcon
var icon_size: Vector2 = Vector2.ZERO

var player: Player

func _ready() -> void:
	icon_size = interaction_icon.get_rect().size
	interaction_icon.visible = false
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
func _process(_delta: float) -> void:
	if player != null:
		var player_size: Vector2 = player.get_size()
		interaction_icon.global_position = Vector2(
			player.global_position.x + (player_size.x / 1.2),
			player.global_position.y,
		)
		interaction_icon.visible = true
	else:
		interaction_icon.visible = false
	
func on_body_entered(body: Node2D) -> void:
	if body is Player: player = body
	
func on_body_exited(body: Node2D) -> void:
	if body is Player: player = null

func _input(event: InputEvent) -> void:
	if event.is_action_released("interact") and player != null:
		Dialogic.start("sample").process_mode = Node.PROCESS_MODE_ALWAYS
