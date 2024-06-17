extends Control

const LEVEL_BUTTON = preload("res://scenes/level_button.tscn")

@onready var hb_levels = %HBLevels

func _ready():
	setup_grid()

func create_level_button(level_number: int) -> void:
	var new_level_button = LEVEL_BUTTON.instantiate()
	hb_levels.add_child(new_level_button)
	new_level_button.set_level_number(level_number)

func setup_grid() -> void:
	for level in GameManager.LEVELS:
		create_level_button(level)
