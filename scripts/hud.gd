extends CanvasLayer

signal start_game

func _on_play_button_pressed() -> void:
	$PlayButton.hide()
	$Message.hide()
	start_game.emit()
