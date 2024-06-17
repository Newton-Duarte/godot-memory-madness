extends Control

const MEMORY_TILE = preload("res://scenes/memory_tile.tscn")

@onready var sound = $Sound
@onready var tile_container = %TileContainer
@onready var scorer: Scorer = $Scorer
@onready var moves_label = %MovesLabel
@onready var pairs_label = %PairsLabel

func _ready():
	SignalManager.level_selected.connect(on_level_selected)

func _process(_delta: float):
	moves_label.text = scorer.get_moves_made_str()
	pairs_label.text = scorer.get_pairs_made_str()

func add_memory_tile(item_info: Dictionary, frame_image: CompressedTexture2D) -> void:
	var new_tile = MEMORY_TILE.instantiate()
	tile_container.add_child(new_tile)
	new_tile.setup(item_info, frame_image)

func on_level_selected(level_number: int) -> void:
	var level_selection = GameManager.get_level_selection(level_number)
	var frame_image = ImageManager.get_random_frame_image()
	
	tile_container.columns = level_selection.num_cols
	for item_info in level_selection.image_list:
		add_memory_tile(item_info, frame_image)
	
	scorer.clear_new_game(level_selection.target_pairs)

func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.game_exit_pressed.emit()
