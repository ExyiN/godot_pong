extends Area2D

signal player_scored(is_right: bool)

@export var is_right: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		player_scored.emit(is_right)
