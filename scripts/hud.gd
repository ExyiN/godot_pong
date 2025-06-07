extends CanvasLayer

signal start_game(is_one_player: bool)

@onready var message: Label = $Message
@onready var p1_label: Label = $P1Label
@onready var p2_label: Label = $P2Label
@onready var score_p1: Label = $ScoreP1
@onready var score_p2: Label = $ScoreP2
@onready var play_button_1p: Button = $PlayButton1P
@onready var play_button_2p: Button = $PlayButton2P

func _on_play_button_pressed(is_one_player: bool) -> void:
	if is_one_player:
		p1_label.text = "Player"
		p2_label.text = "CPU"
	else:
		p1_label.text = "Player 1"
		p2_label.text = "Player 2"
	play_button_1p.hide()
	play_button_2p.hide()
	message.hide()
	start_game.emit(is_one_player)
