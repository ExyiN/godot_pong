extends CharacterBody2D

@export var speed := 200
var screen_size: Vector2
var ball_position: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _on_ball_change_position(b_pos: Vector2) -> void:
	ball_position = b_pos

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	velocity.y = ball_position.y - position.y
	velocity = velocity.normalized() * speed
	move_and_collide(velocity * delta)
	position = position.clamp(Vector2.ZERO, screen_size)
	
