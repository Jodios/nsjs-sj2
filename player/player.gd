class_name Player
extends CharacterBody2D

@export var speed : float = 20500

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var player_sprite: Sprite2D = $Texture
@onready var foot_steps_audio: AudioStreamPlayer2D = $Audio/FootStepsAudio

var previousDirection : Vector2
var is_idle_path = "parameters/conditions/is_idle"
var is_walking_path = "parameters/conditions/is_walking"
var idle_blend_path = "parameters/idle/blend_position"
var walk_blend_path = "parameters/walk/blend_position"

func _ready():
	previousDirection = Vector2.RIGHT
	animation_tree[is_idle_path] = true
	animation_tree[is_walking_path] = false
	
func _process(_delta: float) -> void:
	animation_tree[idle_blend_path] = previousDirection
	animation_tree[walk_blend_path] = previousDirection
	pass
	
func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	move_and_slide()

func _handle_movement(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	var joy_direction = Vector2(
		Input.get_joy_axis(0, JOY_AXIS_LEFT_X),
		Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	)
	if joy_direction.length() < 0.2:
		joy_direction = Vector2.ZERO
	direction += joy_direction
	
	if direction != Vector2.ZERO:
		previousDirection = direction
		animation_tree[is_idle_path] = false
		animation_tree[is_walking_path] = true
		if !foot_steps_audio.playing:
			foot_steps_audio.play(0)
	else:
		animation_tree[is_idle_path] = true
		animation_tree[is_walking_path] = false
		foot_steps_audio.stop()
		
	velocity = direction * speed * delta

func get_size() -> Vector2:
	return player_sprite.get_rect().size
