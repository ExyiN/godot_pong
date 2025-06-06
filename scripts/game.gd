extends Node2D

@export var max_score: int = 5

@onready var ball: Ball = $Ball
@onready var paddle_p1: Paddle = $PaddleP1
@onready var paddle_p2: Paddle = $PaddleP2
@onready var launch_timer: Timer = $LaunchTimer
@onready var hud_score_p1: Label = $HUD/ScoreP1
@onready var hud_score_p2: Label = $HUD/ScoreP2
@onready var hud_message: Label = $HUD/Message
@onready var hud_play_button: Button = $HUD/PlayButton

var score_p1: int = 0
var score_p2: int = 0

func _ready() -> void:
	paddle_p1.hide()
	paddle_p2.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset_scene"):
		get_tree().reload_current_scene()
		
func start_game() -> void:
	hud_score_p1.text = str(score_p1)
	hud_score_p2.text = str(score_p2)
	paddle_p1.reset()
	paddle_p2.reset()
	paddle_p1.show()
	paddle_p2.show()
	launch_timer.start()
	
func game_over() -> void:
	if score_p1 > score_p2:
		hud_message.text = "Player 1 wins!"
	else:
		hud_message.text = "Player 2 wins!"
	hud_message.show()
	hud_play_button.show()
	ball.reset()
	score_p1 = 0
	score_p2 = 0
	
func launch_ball() -> void:
	ball.launch()
	
func _on_score_detector_player_scored(is_right: bool) -> void:
	if is_right:
		score_p1 += 1
		hud_score_p1.text = str(score_p1)
	else:
		score_p2 += 1
		hud_score_p2.text = str(score_p2)
	if score_p1 >= max_score || score_p2 >= max_score:
		game_over()
	else:
		ball.reset()
		launch_timer.start()
