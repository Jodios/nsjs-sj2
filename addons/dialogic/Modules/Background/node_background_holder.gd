class_name DialogicNode_BackgroundHolder
extends ColorRect

var viewport_container: SubViewportContainer

func _ready() -> void:
	add_to_group('dialogic_background_holders')
	child_entered_tree.connect(func(c):
		if c is SubViewportContainer:
			viewport_container = c
	)
