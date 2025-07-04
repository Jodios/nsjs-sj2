class_name Player
extends CharacterBody2D

@export var speed : float = 7500

var previousDirection : Vector2

func _ready():
	previousDirection = Vector2.RIGHT
	
func _process(delta: float) -> void:
	# This is run each frame so the timing isn't constant
	pass
	
func _physics_process(delta: float) -> void:
	# this is run at a fixed rate through the physics engine
	# physics and process won't be in sync so only physics related
	# logic should be written here
	_handle_movement(delta)
	move_and_slide()

func _handle_movement(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		previousDirection = direction
	velocity = direction * speed * delta
