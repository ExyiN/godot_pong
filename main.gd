extends Node

@export var ball_scene: PackedScene
@export var max_score := 7
var score := {1: 0, 2: 0}
var ball: Node
	
func _on_top_body_entered(body: Node2D) -> void:
	body.velocity.y = -body.velocity.y

func _on_bottom_body_entered(body: Node2D) -> void:
	body.velocity.y = -body.velocity.y

func _on_left_body_entered(_body: Node2D) -> void:
	var new_score = add_score(2)
	$HUD/ScoreP2.text = str(new_score)

func _on_right_body_entered(_body: Node2D) -> void:
	var new_score := add_score(1)
	$HUD/ScoreP1.text = str(new_score)

func add_score(player_id: int) -> int:
	var player_new_score: int = score.get(player_id) + 1
	score.set(player_id, player_new_score)
	if player_new_score >= max_score:
		game_over(player_id)
	else:
		ball.queue_free()
		$BallTimer.start()
	return player_new_score
	
func _on_ball_timer_timeout() -> void:
	new_round()
	
func new_game() -> void:
	$HUD/Message.text = "First to " + str(max_score)
	score = {1: 0, 2: 0}
	$HUD/ScoreP1.text = "0"
	$HUD/ScoreP2.text = "0"
	new_round()
	
func new_round() -> void:
	ball = ball_scene.instantiate()
	var ball_spawn_location = $BallPath/BallSpawnLocation
	ball_spawn_location.progress_ratio = randf()
	
	ball.position = ball_spawn_location.position
	ball.change_position.connect($Player2._on_ball_change_position)
	
	add_child(ball)
	
func game_over(player_id: int) -> void:
	$HUD/Message.text = "Player " + str(player_id) + " win!"
	$HUD/PlayButton.show()
