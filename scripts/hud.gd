extends CanvasLayer

signal start_game

func _on_play_button_pressed() -> void:
	$PlayButton.hide()
	start_game.emit()
