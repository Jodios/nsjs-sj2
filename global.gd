extends Node

@export var is_dev = true

var trigger_end = false
var interacted_with_ghost_today = false
var day: int = 1

enum Dialogue {
	WeirdLittleGirl,
	WeirdGuy,
	Intro,
	Day2Intro,
	Day3Intro,
	Bed,
	BedsideTable,
	FridgeStove,
	CuttingBoard,
	KitchenTable,
	Couch,
	LivingRoomTable,
	Pond,
	Well,
	End
}
var dialogues = {
	Dialogue.WeirdLittleGirl: "little_girl_dialogue",
	Dialogue.WeirdGuy: "weird_guy_dialogue",
	Dialogue.Intro: "intro_dialogue",
	Dialogue.Day2Intro: "day_2_intro",
	Dialogue.Day3Intro: "day_3_intro",
	Dialogue.End: "end",
	
	
	# I HATE that I'm doing this but 
	# I'm really running out of time so fuck it
	Dialogue.Bed: {
		"before_meeting_ghost": {
			1: ["bed_1_diologue"],
			2: ["bed_2_diologue"],
			3: ["bed_4_diologue"],
		},
		"after_meeting_ghost": {
			1: ["bed_1_diologue"],
			2: ["bed_3_diologue"],
			3: ["bed_4_diologue"],
		},
	},
	Dialogue.BedsideTable: {
		"before_meeting_ghost": {
			1: ["bedside_table_1"],
			2: ["bedside_table_2"],
			3: [],
		},
		"after_meeting_ghost": {
			1: ["bedside_table_1"],
			2: ["bedside_table_2"],
			3: [],
		},
	},
	Dialogue.FridgeStove: {
		"before_meeting_ghost": {
			1: ["fridge_stove_1","fridge_stove_2"],
			2: ["fridge_stove_1","fridge_stove_2"],
			3: ["fridge_stove_3"],
		},
		"after_meeting_ghost": {
			1: ["fridge_stove_1","fridge_stove_2"],
			2: ["fridge_stove_1","fridge_stove_2"],
			3: ["fridge_stove_3"],
		},
	},
	Dialogue.CuttingBoard: {
		"before_meeting_ghost": {
			1: ["cutting_board_1"],
			2: ["cutting_board_2"],
			3: ["cutting_board_2"],
		},
		"after_meeting_ghost": {
			1: ["cutting_board_1"],
			2: ["cutting_board_2"],
			3: ["cutting_board_3"],
		},
	},
	Dialogue.KitchenTable: {
		"before_meeting_ghost": {
			1: ["kitchen_table_1"],
			2: ["kitchen_table_2"],
			3: ["kitchen_table_2"],
		},
		"after_meeting_ghost": {
			1: ["kitchen_table_1"],
			2: ["kitchen_table_2"],
			3: ["kitchen_table_2"],
		},
	},
	Dialogue.Couch: {
		"before_meeting_ghost": {
			1: ["couch_1"],
			2: ["couch_1"],
			3: ["couch_1"],
		},
		"after_meeting_ghost": {
			1: ["couch_1"],
			2: ["couch_1"],
			3: ["couch_2"],
		},
	},
	Dialogue.LivingRoomTable: {
		"before_meeting_ghost": {
			1: ["living_room_table_1"],
			2: ["living_room_table_2"],
			3: ["living_room_table_2"],
		},
		"after_meeting_ghost": {
			1: ["living_room_table_1"],
			2: ["living_room_table_2"],
			3: ["living_room_table_2"],
		},
	},
	Dialogue.Pond: {
		"before_meeting_ghost": {
			1: ["pond_1","pond_2"],
			2: ["pond_1","pond_2"],
			3: ["pond_4"],
		},
		"after_meeting_ghost": {
			1: ["pond_1","pond_2"],
			2: ["pond_3"],
			3: ["pond_4"],
		},
	},
	Dialogue.Well: {
		"before_meeting_ghost": {
			1: ["well_1","well_2"],
			2: ["well_3"],
			3: ["well_1","well_2"],
		},
		"after_meeting_ghost": {
			1: ["well_1","well_2"],
			2: ["well_3"],
			3: ["well_4"],
		},
	},
}

enum Rooms {LivingRoom, Bedroom, Garden, Kitchen}
var scences = {
	Rooms.LivingRoom: preload("res://scenes/rooms/living-room.tscn"),
	Rooms.Bedroom: preload("res://scenes/rooms/bedroom.tscn"),
	Rooms.Garden: preload("res://scenes/rooms/garden.tscn"),
	Rooms.Kitchen: preload("res://scenes/rooms/kitchen.tscn"),
}
var to_path = null
var dialogic_started = false

func _ready() -> void:
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.signal_event.connect(func(input):
		if input is not Dictionary: return
		if "background" in input:
			Backgrounds.fade_in_image(input["background"])
		if "dialogue" in input:
			print("Starting ", input["dialogue"], " dialogue")
			if dialogic_started:
				await Dialogic.timeline_ended
			Dialogic.start(input["dialogue"])
		if "interacted_with_ghost" in input:
			interacted_with_ghost_today = input["interacted_with_ghost"]
		if "day" in input:
			day = input["day"]
			interacted_with_ghost_today = false
		if "trigger_end" in input:
			trigger_end = true
		if "scene" in input:
			Global.to_path = null
			get_tree().change_scene_to_packed(Global.scences[Global.Rooms.Bedroom])
	)
	Dialogic.timeline_started.connect(func():
		dialogic_started = true
		for c in get_tree().root.get_children():
			if c is Room:
				c.process_mode = Node.PROCESS_MODE_DISABLED
	)
	Dialogic.timeline_ended.connect(func():
		dialogic_started = false
		for c in get_tree().root.get_children():
			if c is Room:
				c.process_mode = Node.PROCESS_MODE_INHERIT
	)

func _input(event: InputEvent) -> void:
	if event.is_action_released("exit") and is_dev:
		get_tree().quit()
