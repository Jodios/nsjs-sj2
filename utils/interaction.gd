extends Area2D

@export var dialogue: Global.Dialogue

@onready var interaction_icon: Sprite2D = $InteractIcon
var icon_size: Vector2 = Vector2.ZERO

var player: Player
var has_interacted = false
var cooldown: bool = false

func _ready() -> void:
	icon_size = interaction_icon.get_rect().size
	interaction_icon.visible = false
	if (dialogue == Global.Dialogue.End && Global.interacted_with_ghost_today) or dialogue != Global.Dialogue.End:
		body_entered.connect(on_body_entered)
		body_exited.connect(on_body_exited)
	Dialogic.timeline_started.connect(func():
		cooldown = true
	)
	Dialogic.timeline_ended.connect(func():
		get_tree().create_timer(1.5).timeout.connect(func():
			cooldown = false
		)
	)
	
func _process(_delta: float) -> void:
	if player != null:
		if dialogue == Global.Dialogue.End and !has_interacted and Global.trigger_end:
			start_dialogue()
		var player_size: Vector2 = player.get_size()
		interaction_icon.global_position = Vector2(
			player.global_position.x + (player_size.x / 1.2),
			player.global_position.y,
		)
		interaction_icon.visible = true
	else:
		interaction_icon.visible = false

func get_diologue_name() -> String:
	var dialogue_object = Global.dialogues[dialogue]
	if dialogue_object is String:
		return dialogue_object
	var dialogue_options: Array = dialogue_object["after_meeting_ghost" if Global.interacted_with_ghost_today else "before_meeting_ghost"][Global.day]
	if !dialogue_options.is_empty():
		var random_option = dialogue_options[randi() % dialogue_options.size()]
		return random_option
	return ""
	
func on_body_entered(body: Node2D) -> void:
	if body is Player: player = body
	
func on_body_exited(body: Node2D) -> void:
	if body is Player: player = null

func _input(event: InputEvent) -> void:
	if event.is_action_released("interact") and player != null && !cooldown:
		start_dialogue()



func start_dialogue() -> void:
	var dialogue_name = get_diologue_name()
	if dialogue_name != "":
		has_interacted = true
		Dialogic.start(get_diologue_name()).process_mode = Node.PROCESS_MODE_ALWAYS
	
