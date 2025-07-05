class_name Player
extends CharacterBody2D

@export var speed : float = 20500

@onready var animation_tree: AnimationTree = $AnimationTree

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
	if direction != Vector2.ZERO:
		previousDirection = direction
		animation_tree[is_idle_path] = false
		animation_tree[is_walking_path] = true
	else:
		animation_tree[is_idle_path] = true
		animation_tree[is_walking_path] = false
		
	velocity = direction * speed * delta
