extends RigidBody2D

signal change_position(b_pos: Vector2)

@export var speed := 300
var velocity := Vector2.ZERO
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * speed

func _process(delta: float) -> void:
	var collision_data := move_and_collide(velocity * delta)
	if collision_data:
		velocity = velocity.bounce(collision_data.get_normal())

func _on_signal_timer_timeout() -> void:
	change_position.emit(position)
