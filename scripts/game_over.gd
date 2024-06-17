extends Control

@onready var moves_label = %MovesLabel


func _ready():
	SignalManager.game_over.connect(on_game_over)

func on_game_over(moves: int) -> void:
	moves_label.text = str(moves)
	show()

func _on_exit_button_pressed():
	hide()
	SignalManager.game_exit_pressed.emit()
