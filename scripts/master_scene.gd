extends CanvasLayer

@onready var main_screen = $MainScreen
@onready var game_screen = $GameScreen
@onready var sound = $Sound

func _ready():
	on_game_exit_pressed()
	SignalManager.game_exit_pressed.connect(on_game_exit_pressed)
	SignalManager.level_selected.connect(on_level_selected)

func show_game(show: bool) -> void:
	game_screen.visible = show
	main_screen.visible = !show

func on_game_exit_pressed() -> void:
	show_game(false)
	GameManager.clear_nodes_of_group(GameManager.GROUP_TILE)
	SoundManager.play_sound(sound, SoundManager.SOUND_MAIN_MENU)

func on_level_selected(level_number: int) -> void:
	show_game(true)
	SoundManager.play_sound(sound, SoundManager.SOUND_IN_GAME)
